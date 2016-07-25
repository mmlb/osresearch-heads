Heads: the other side of TAILS
===

Heads is a configuration for laptops that tries to bring more security
to commodity hardware.  Among its goals are:

* Use free software on the boot path
* Move the root of trust into hardware (or at least the ROM)
* Measure and attest to the state of the firmware
* Measure and verify all filesystems

It is a work in progress and not yet ready for users.

---

Components:

* CoreBoot
* Linux
* busybox
* kexec
* tpmtotp
* QubesOS (Xen)
