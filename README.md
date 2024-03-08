HPC Workshop
============

Notes are organised by days:

- [Day 1](./day_1.md)
- [Day 2](./day_2.md)
- [Day 3](./day_3.md)
- [Day 4](./day_4.md)
- [Day 5](./day_5.md)

Also there is a bunch of examples in the 01_AIMS and 02_AIMS folders. These are currently on the HPC and can be mounted with:

`sshfs HPC:/export/home/f-k/jjohnsto/01_AIMS ~/Workspace/HPC_workshop/01_AIMS`

HPC connection has been set up like so:
```
Host HPC
  HostName hpc-l001.aims.gov.au
  User jjohnsto
  IdentityFile /home/jjohnsto/.ssh/id_ed25519_3JYJLX3_HPC
```

I have also mounted the remote HPC folders with:

```
sshfs HPC:/export/home/f-k/jjohnsto/01_AIMS ~/Workspace/HPC_workshop/01_AIMS
sshfs HPC:/export/home/f-k/jjohnsto/02_AIMS ~/Workspace/HPC_workshop/02_AIMS
sshfs HPC:/export/home/f-k/jjohnsto/03_AIMS ~/Workspace/HPC_workshop/03_AIMS
sshfs HPC:/export/home/f-k/jjohnsto/r_lesson ~/Workspace/HPC_workshop/r_lesson
sshfs HPC:/export/home/f-k/jjohnsto/HMMER ~/Workspace/HPC_workshop/HMMER 
```

Most of these originally came from `/export/home/l-p/llafayet`
but r_lesson came from `/export/home/a-e/dbarnech/`

Lev's git repo: https://github.com/levlafayette/2024-AIMS-HPC
