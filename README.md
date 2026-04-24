# MediaHelper.jl

## Installation
``MediaHelper.jl`` requires the julia programming language. Please use the instructions from the following link to install [julia](https://julialang.org/downloads/).

Once julia is installed, you can start up julia in a terminal by typing ``julia``. Once inside julia, you can install the ``MediaHelper`` package in one of two ways.

The simplest way is to type the ``]`` key which will swith the julia REPL to the package manager mode (you should see a blue ``(@v1.12) pkg>`` symbol although ``v1.12`` may differ depending upon the current julia version). Once in the package manager type

``
add https://github.com/cmhamel/MediaHelper.jl
``

The other way is to do the following in the julia REPL.
```julia
import Pkg
Pkg.add(url="https://github.com/cmhamel/MediaHelper.jl")
```

## Organizing folders of images using image Metadata
The only currently supported feature of the package is ``organize_images``. This method takes in a folder name, iterates through every image in that folder recursively, and organized them into date stamped folders in the format ``YYYY_MM``. To do this type

```julia
import MediaHelper as MH
MH.organize_images("/my/folder/of/images/")
```
where ``/my/folder/of/images`` is the actual path to your folder.

By default this will organize image into a folder called ``organized`` in the current directory that you ran julia from. If you would like to call it something else, you can do the following

```julia
import MediaHelper as MH
MH.organize_images("/myfolder/of/images"; organized_folder = "/path/to/my/organized/folder")
```