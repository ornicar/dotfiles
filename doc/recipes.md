## change open file limit of process

like when pipewire-pulse complains about "Too many open files"

```sh
_ prlimit --pid 2671 --nofile=4096:524288
```
