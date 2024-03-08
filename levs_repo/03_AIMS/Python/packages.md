# Managing Python Extensions

## What's Loaded?

$ module load python37
$ python3
..
> help("modules")

There's quite a few, right?

## Virtual Environments

Short for 'Virtual Environment', a virtualenv allows you to create an isolated working copy of Python. This enables you to add and modify 
Python modules without write access to the global installation.

Load a python module and check that virtualenv is available

$ module load python37
$ which virtualenv
/cm/local/apps/python37/bin/virtualenv

Create a directory inside the home directory for the isolated environment.

$ mkdir ~/venvs

Then create the virtualenv

$ virtualenv ~/venvs/python3.7.12
...
...


Activate the virtual environment, run python actions, and deactivate when complete.

$ source ~/venvs/venv-3.7.12/bin/activate
(venv-3.7.12) $ pip install flash
$ deactivate

See the script virt.slurm for an example with Slurm.

## Conda

The following is derived from Compute Canada, and everyting they say is accurate: ​ 

* Conda often installs software (compilers, scientific  libraries etc.) which already exist on as modules, with a configuration that is not optimal.

* It installs binaries which are not optimized for the processor architecture on our clusters.

* It makes incorrect assumptions about the location of various system libraries.

* Conda uses the $HOME directory for its installation, where it writes an enormous number of files, reducing your disk quota (virtenv is c15 
mb of disk, Conda is > 100mb - and then more and more and more).

* Conda is slower than the installation of Python packages.

* Conda modifies the $HOME/.bashrc file, which can easily cause conflicts.
​
Also, do not mix Conda with modules. It will be a mess.


To use Conda:

$ module load conda/anaconda3
(base) $ conda activate
(base) $ conda install flash
(base) $ conda list
(base) $ conda deactivate


See the file conda.slurm for an example with Slurm.

List of commands
https://docs.conda.io/projects/conda/en/latest/commands.html
