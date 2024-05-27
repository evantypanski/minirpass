# Example minIR pass

> [!IMPORTANT]
> This is incomplete! In its current state, this is more of meant to be the initial implementation of minIR-as-a-library. It is not meant to be a final unveiling or anything of the sort. Feel free to use it, but use it at your own risk. It may also be useful to grab minIR locally and use that as the library in the `build.zig.zon` file. Use `zig fetch --save <path>` to use the local minIR path.

This is an example pass using [minIR](https://github.com/evantypanski/minir) as a library. Note that it is more than useless, it is simply a demonstration to get you going.

Built using:

```
etyp:~/ $ zig version
0.13.0-dev.60+d841f84b8
```

Feel free to run it on the two examples to see its output:

```
$ zig build
$ zig-out/bin/minirpass examples/count_to_42.min
$ zig-out/bin/minirpass examples/count_to_41.min
```

