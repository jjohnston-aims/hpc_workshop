# Managing Python modules

## What is a virtualenv?
Short for 'Virtual Environment', a virtualenv allows you to create an isolated working copy of Python. This enables you to add and modify Python modules without write access to the global installation.

## Load a python module and check that virtualenv is available
```
$ module load GCCcore/11.3.0 
$ module load Python/3.10.4
$ which virtualenv
/apps/easybuild-2022/easybuild/software/Compiler/GCCcore/11.3.0/Python/3.10.4/bin/virtualenv
$ virtualenv --version
virtualenv 20.14.1 from /apps/easybuild-2022/easybuild/software/Compiler/GCCcore/11.3.0/Python/3.10.4/lib/python3.10/site-packages/virtualenv/__init__.py
```

Looks good, we have a `virtualenv` binary available to use.

## Setup your own virtualenv
Firstly, let's create a directory inside your home directory for your new isolated environment.
```
$ mkdir ~/virtualenv
```
Next, let's create the virtualenv.

```
$ virtualenv ~/virtualenv/python3.10.4
created virtual environment CPython3.10.4.final.0-64 in 5176ms
  creator CPython3Posix(dest=/home/lev/virtualenv/python3.10.4, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/home/lev/.local/share/virtualenv)
    added seed packages: pip==22.0.4, setuptools==68.0.0, wheel==0.40.0
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator
```

To begin working with your project, you'll need to activate the virtual environment. This is done by using `source` on the `activate` script found inside your virtualenv.
```
$ source ~/virtualenv/python3.10.4/bin/activate
```
Your shell prompt (`$PS1`) will change to something like:
```
(python3.10.4)[USER@MACHINE]$ 
```

## Install a package in your virtualenv
If you look at the bin directory in your virtualenv, you'll see `easy_install` and `pip`. These versions have been modified to put eggs and packages in the virtualenv's site-packages directory.

In this example, we'll install and use a local copy of `flask`:
```
(python3.10.4)[USER@MACHINE]$ pip install flask
(python3.10.4)[USER@MACHINE]$ python
[GCC 11.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import flask
```

You can use `pip` to install any python module you like at any version you like.

## Exit Your virtualenv
To exit your virtualenv use `deactivate`:
```
(python3.10.4)[USER@MACHINE]$ deactivate 
```

Your shell prompt will then return to normal.

## Reusing you virtual environment

Next time you want to use your virtualenv, just load the Python module and source the virtualenv `activate` script:
```
$ module load GCCcore/11.3.0 python/3.10.4
$ source ~/virtualenv/python3.8.6/bin/activate
(python3.10.4)[USER@MACHINE]$ python
[GCC 11.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import flask
```
