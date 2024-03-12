HPC Workshop day 2
==================

Meeting link (with recording): https://teams.microsoft.com/_?culture=en-au&country=au#/scheduling-form/?isBroadcast=false&eventId=AAMkAGI0MTg0NTNlLTFkZGYtNGZlMy05ZjUwLTU1NzMxMjVjMTFjMgBGAAAAAAAUNLPbvTbAT4zd40IvswVzBwDPdM72SAffSKYUUpfX064IAAAAAAENAADPdM72SAffSKYUUpfX064IAAH_ijrHAAA%3D&conversationId=19:meeting_MjZkYzgxMTYtMzk2NC00OGM1LTgwNjAtYTc2OWMyMjJjNWY3@thread.v2&opener=1&providerType=0&navCtx=navigateHybridContentRoute&calendarType=1

Links, etc
----------

- [Unix command line examples for speed](https://adamdrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html)
  - "...Since the data volume was only about 1.75GB containing around 2 million chess games, I was skeptical of using Hadoop for the task, ... Since the problem is basically just to look at the result lines of each file and aggregate the different results, it seems ideally suited to stream processing with shell commands. I tried this out, and for the same amount of data I was able to use my laptop to get the results in about 12 seconds (processing speed of about 270MB/sec), while the Hadoop processing took about 26 minutes (processing speed of about 1.14MB/sec)."
- [faster than SQL](https://www.spinellis.gr/blog/20180805/index.html)
  - the author has a join that does a full scan, then an index lookup based on the join field. Instead, he exported the two tables into files, joined them with with the Unix join command, piped the result to uniq to remove the duplicate rows, and imported the result back into the database.
  - I think it was initially so slow because MariaDB doesn't support sort-merge joins, the server had low memory, and a HDD.
- [vimgolf minimal keystroke challenges](https://www.vimgolf.com/)

Tarballs
--------

Check the contents before extracting, `tar -tf tarball.tar`

If the structure is poor it will put a load of files in the current directory, this is called a tarbomb. Recovering from a tarbomb: `tar -tf tarbomb.tar | xargs rm -rf`

Make a tarball: `tar cvfz OUTPUT_NAME.tgz SOURCE_DIRECTORY/`

There are other compression algorithms like xz (with `-J` flag).

Pipes and redirects
-------------------

### redirect STDOUT

Both STDOUT and STDERR go to the terminal so if you get an error and try to redirect it into a file, it wont work because a `>` redirect implies `1>`. This redirects stream 1 (which is STDOUT) to a file.

- fd0: STDIN `<`
- fd1:  STDOUT `>` or `1>`
- fd2:  STDERR `2>`

You can append STDERR to STDOUT: with `2>&1`, or `&>`.

### variable redirects

`<<< $some_variable`

### tee

Tee allows you to create a file like a redirect and then pipe it into another command. This is useful for logging. Think of it like a T intersection.

Also writes to STDOUT (unless that is piped to another command).

Process streams
---------------

In unix everything is a file, including process streams.

You can generate a process stream from a command and use it like a file with `<()`

Eg, `diff <(ssh HPC ls -R ~/jjohnsto/01_AIMS) <(ls -R ~/01_AIMS)`

### quote redirection

quote redirection allows you to perform redirect on the remote. only relevant after ssh command

after ssh, put any command in quotes `''` to run it in the remote location. eg, 

`ssh HPC ls ~/jjohnsto/01_AIMS > ~/files.txt` will create a file called `files.txt` locally.

`ssh HPC ls ~/jjohnsto/01_AIMS '>' ~/files.txt` will create a file called `files.txt` in the remote location.

ls -l
-------

Example output:

```
total 24
drwxrwxrwx 2 jjohnsto jjohnsto        4096 Mar  5 08:49 01_AIMS
drwxr-xr-x 1     2411 systemd-resolve  197 Mar  5 09:37 02_AIMS
-rwxrwxrwx 1 jjohnsto jjohnsto        5344 Mar  5 10:02 day_1.md
-rw-r--r-- 1 jjohnsto jjohnsto        1915 Mar  5 10:05 day_2.md
drwxrwxrwx 3 jjohnsto jjohnsto        4096 Mar  4 13:28 levlafayette
```

First character is type. `b` is block device, `c` is character device (one character at time like a mouse), `-` is a normal file.

### chmod

chmod USER +-= on rwx for a file. if not user or group, all is the default.


| actions          | owner, group, or others          |
| ---------------- | -------------------------------- |
| r                | 4                                |
| w                | 2                                |
| x                | 1                                |

### inode numbers

see with `ls -i file_name`

Files have metadata (name, date, inodenumber) and data.

inode numbers tell us where the data is.

When you remove a file with `rm` the data is not removed, just the metadata. Tools like foremost can potentially recover deleted files.

hardlinks point to the same data and have same inode number.

symbolic links point to the original file. Dead links are symbolic links that have the source removed.

Symbolic links can link to directories and across file systems.

Hard and symbolic links don't work on ntfs. Samba emulate windows filesystems for linux and macs and can be used for working accross filesystems.

File manipulation
-----------------

`head` and `tail` - view the start or end of a file.

on debian systems: `rename 's/old/new/' files`. Redhat has a different syntax.

`split` is useful. `split -l 500 -d quakes.csv shakes`. splits the file into 500 lines each.

cut FIELD DELIMETER FILE
`cut -f3 -d, quakes.csv > latitude.txt`

paste -d DELIMETER FILE1 FILE2
`paste -d " " latitude.txt longitude.txt > latlong.txt`

`join` will join based on a common filed.

`sort` sorts alphabetically by default. `sort -g` will sort numerically.

`uniq` will remove duplicate lines.

`tr` does simple search and replace. Eg:

- `tr 1 X < sortfile` substitutes 1 with X
- `tr [A-Z] [a-z] < sortfile` substitutes all capital letters with lower case
- `tr -d 4 < sortfile` deletes all instances of 4

Regex
-----

grep

some useful regex example that are usually cross syntax.

- `[[:punct:]]`
- `[[:alpha:]]`
- `[[:alnum:]]`
- `[[:digit:]]`
- see more at 02_AIMS/RegEx/BREandERE.md

## sed and awk

### sed

resource: https://www.grymoire.com/Unix/Sed.html#uh-8

`sed -f SCRIPT_FILE`

`sed -i` for in place editing.

'COMMAND/SCRIPT/FLAG'

eg, `s/^/  /g`

substiute start of the line for 2 spaces, do it globally.

eg `'/ELM/s/N/\$/g'`

"ELM" part filters lines to match the string., the last part (the flag) will only substitute the 3rd match.

Can put multiple commands into sed. Just separate them by `;`

A useful sed command for trimming leading and trailing whitespace and empty lines: `sed 's/^[ \t]*//;s/[ \t]*$//;/^$/d' FILENAME`

`sed '2d FILENAME'` to delete line 2.

Transferring files from uniq to dos, use either:
sed 's/$/\r/' FILENAME
sed 's/\r$//' FILENAME

Useful one-line sed scripts: http://sed.sourceforge.net/sed1line.txt

TODO: find sed koans

TODO: find out how to do the global print commands

### awk

aws uses space as internal field separator. need to tell it to use other things (like `,`) if applicable.

Can remove first row with awk: `awk 'NR > 1' FILENAME`

specify a single digit field specifier with `-F"SEPARATOR"`.

`||` is or and `&&` is and. eg `awk '(NR < 2) || (NR > 10)' FILENAME` gets rows less than 2 or greater than 10.

can count instances of a value in a column or sum a column.

https://gregable.com/2010/09/why-you-should-know-just-little-awk.html

### Resources

- https://www.pement.org/awk/awk1line.txt
- "sed & awk, 2nd Edition," by Dale Dougherty and Arnold Robbins
  (O'Reilly, 1997)
- "UNIX Text Processing," by Dale Dougherty and Tim O'Reilly (Hayden
  Books, 1987)
- ["GAWK: Effective awk Programming," by Arnold D. Robbins (O'Reilly)](http://www.gnu.org/software/gawk/manual/)
- [The Unix Programming Environment (Prentice-Hall Software Series)]https://www.amazon.com/Unix-Programming-Environment-Prentice-Hall-Software/dp/013937681X)

## Bash scripts

`$?` stores the output of the last command

Good for creating aliases. extracting

```bash
# Source Disk, Function Example
disk() {
        du -sk * | sort -nr | cut -f2 | xargs -d "\n" du -sh  > diskuse.txt
        }
```
TODO: implement this function in my aliases, but add -h to include hidden files.

### cat to EOF

```bash
echo "description:"
cat <<- EOF
   Blah blah blah,
   big long string of Text
EOF # note: EOF must be at the start of the line I think
```

Note `<<` will take the text until EOF as it is. `<<-` will strip leading tabs. Useful for readability in scripts.

cat to EOF can also be redirected. Useful in a for loop:

```bash
for job_number in {01..10}
do
cat <<- EOF > job_${job_number}.sh
   Blah blah blah,
   big long string of Text.
   with some instruction to do some stuff
EOF
done
```

in this case the redirect `>` happens after the text to EOF is obtained.

### curly braces

Used for parameter expansion, or brace expansion.

TODO: read more about this. Why is it useful.

### quotes

Weak quotes "" will expand varaibles and do command substitution.

Command substitution is $(command). Backticks also work (eg, `$(command)`), however this is not POSIX compliant and not as readable.

Strong quotes '' make anything inside literal.

It's a good habit to put every name in double quotes just in case ther are meta characters.

### for loops

checks status of jobs.

`for host in "hpc-c"{001..009}; do squeue -w $host; done`

See `./HPC_workshop/02_AIMS/AdvLinux/loops.txt`.

#### breaking loops

`break` inside a loop (usually inside an if statmente) will break the loop.

`continue` inside a loop will skip the rest of the current iteration of the loop.

### exiting

`exit 0` at the end of a bash script will clear variables and indicated that the script ran successfully.

### Menus

This bash script asks shows the options and allows the user to select one.

```bash
#!/bin/bash
PS3="please select an option: "
OPTIONS="a b c Quit"
select opt in $OPTIONS; do
  if [ "$opt" = "a" ]; then
    echo "Option a selected"
  elif [ "$opt" = "b" ]; then
    echo "Option b selected"
  elif [ "$opt" = "c" ]; then
    echo "Option c selected"
  elif [ "$opt" = "Quit" ]; then
    echo "Exiting..."
    break
  else
    echo "Invalid option, please choose a number between 1 and 4."
  fi
done
```

or 

```bash
#!/bin/bash
PS3="please select an option: "
OPTIONS="a b c Quit"
select opt in $OPTIONS; do
echo "$opt was selected"
break
done

echo "hello $opt"
```

Read more here: https://chat.openai.com/c/27d08223-1706-44d9-977b-87d2a86cb9f3

### eval

Don't use if you don't know what the variable are in the command.

### background tasks

put `&` at the end of a command to run it in the background. It will return a process ID, which you can use to kill the process or check when it's finished with `jobs`. a job back into the forground with `fg %1`, which puts the first jobs back in the foreground? `bg %1`. 1 in this case is the first job returned by `jobs`?

## cron type jobs

See cron.slurm for example

not guaranteed to run at the time requested, but will run as soon after as it can get resources.








## paralelisation

TODO: clarify multi thread vs MPI HPC jobs. each needs to be supported by the code & program we run with?

multithread programs run on single node, with shared memory (ie shared in the node), not distributed.

multithred - ntasks=1
cups-per-task=8 (all on the same node)

MPI:

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
# this mean 16 tasks total (defualt is 1 task per core) accross 2 nodes.

1 task per core is the default. program can be written for multithread and can have cpu-per-task option as well.

## Questions

- What are singleton dependencies? if it's alredy running it won't run itself again. TODO: what does this mean?

