# tagsSys
A tagging CLI allow the user to write, read, display and export tags of a list of files in a given directory.

## Usage:
The `macosTags` assumed to be installed on a given machine. The current command
line is a wrapper around the `tag` CLI which is written in `swifit`, check the references below


```shell
OPTIONS:
   -h, --help           show this help.
   -d, --display        display all tags for list of files in a given directory.
   -s, --searching      searching for a tag in a list of files in a given directory.
   -e, --export         export all tags for list of files in a given directory.
   -w, --write-tags     write all tags for list of files in a given directory.

```

- [TagSys in action](./artifacts/IMG01_01.png)



## Dependencies and Installtion
### Installing from source
Current at my `macbook 13`

#### Steps -1-
Download, compile with `xcrun` + `swiftc`, and copy the executable file to `/usr/local/bin/tags`:
```shell
git clone https://github.com/chbrown/macos-tags
cd macos-tags
make install
```
The installing directory can be changed via the `BINDIR` environment variable (default: `/usr/local/bin`).
#### Step -2-
optional, but very useful,
you have to create a directory at home directory called `~/.macosTags/macos-tags/`, Then applying `Step-1-` to build inside this directory.
use a `simlink` to connect your binary built with a `shortcut` that will be loaded automatically the binary location using

```shell
# Head to the directory
cd ~/.macosTags/macos-tags/bin
## hint I gave a name `macosTags` customed to distiguish from the other similar command called `tag` and avoid duplicates or clash due to similar names.
## the simlink (shortcut) formula is ln -s <binary build location> <shortcut build location>
ln -s ./tags  /usr/local/bin/macosTags
```

Now, we have a shell command `macosTags`, that can be used for the tagging

#### Step -3-
How to write a tag to a file (e.g., PDF) that you just read,

```shell
macosTags write file [tag1 ...]

```
### How to use
To use the `macosTags` command, we can go to the directory where I stored many files and directories.
and I suppose to get files like following, assume you have a file called `ResearchWebsites.md` and it has been tagged already using the `macosx` colored circles,
to see the tags, use

```shell
macosTags read -v Fundamentals/Researchwebsites.md
```

To check all the tags of all the books and files use

```shell
macosTags read ./Fundamentals/* --verbose
```

### Step -4-
You can now install the `macosTags` wrapper CLI at your home directory using

```shell
git clone https://github.com/Ghasak/tagsSys
```


## References:
- [macos-tags](https://github.com/chbrown/macos-tags)
