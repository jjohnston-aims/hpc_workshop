When creating filenames any character can be used except to the `/` because t hat is a directory delimiter.

However, just because (almost) any character can be used, doesn't mean any character should be used. Spaces in filenames, for example, are a 
bad practise.

$ touch "This is a long file name"   
$ for item in $(ls *); do echo ${item}; done

Filenames with wildcards are not a particularly good idea either.

$ touch * # What are you thinking?!
$ rm * # Really?! You want to remove all files in your directory? DON'T DO THIS!
$ rm '*' # Safer, but shouldn't have been created in the first place.

Best to keep to plain, old fashioned, alphanumerics. Snake_case or PascalCase is helpful.

$ touch snake_case.txt
$ touch PascalCase.txt
$ touch camelCase.txt
