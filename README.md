# docker-nonroot-build
This is a strawman for a nonroot build for future container images.

The goals of this image:
1. Allow the user to use certain privileged commands, like apt and yum, via sudo
2. Ensure that the final uid and gid process is nonroot
