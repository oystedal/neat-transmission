# NEAT port of libtransmission

The files containing modifications to use NEAT is in the `libtransmission`
folder:

- `session.c`: This is where the NEAT context is initialized and the incoming
  flows are accepted. Incoming connections originate here, and are handled in
`tr_peerIoNewIncomingNEAT` in `peer-io.c`.
- `peer-io.c`: This file deals with the peer-to-peer communication. This is the
  central 
- `peer-mgr.c`: This is where outgoing connections are initiated. This is
  handled by `tr_peerIoNewOutgoing`.
- `trevent.c`: This is where the event loop in NEAT is called from.

The porting of libtransmission has been greatly eased by the fact that it was
already partly asynchronous, with the exception of setting up connections. The
uTP code used in libtransmission has also been a source of inspiration for the
NEAT callbacks.

Tested with the `d00df9` revision of NEAT.

### Building and usage

#### First time

To build, `cd` to the `build` directory and execute the `init.sh`.
Make symlinks or copies of the following files from the directory of NEAT:

- `path/to/neat/neat.h`, `path/to/neat-transmission/third-party/libneat/neat.h`
- `path/to/neat/libneat.so`, `path/to/neat-transmission/third-party/libneat/libneat.so`
- `path/to/neat/libneat.so.0`, `path/to/neat-transmission/build/libneat.so.0`

Execute `build.sh` while inside the `build` directory to start building.

#### Rebuild

Simply execute `build.sh` from inside the `build` directory.

#### Example

`example.sh` will download a ISO image for Ubuntu.

You can redirect stderr to a different terminal by doing the following:

- Open a terminal and execute `tty`. The output will be something like `/dev/pts/2`.
- Open a new terminal, `cd` to the `build` directory, and execute `./example.sh 2> /dev/pts/2` (substituting with the output you get from `tty`).


### Shortcomings

* The code setting up outgoing NEAT connections handle only a single outgoing
  connection attempt. The reason for this is that the original code for setting
  up connections was synchronous. To make it asynchronous, I have split the
  original function into two.
* Only peer-to-peer I/O uses NEAT. Announces are still done using regular
  sockets, possibly through libcurl.
* The bandwidth limitation code that was in place before the port has not been
  taken into consideration.

Original README below
================================================================================

## About

Transmission is a fast, easy, and free BitTorrent client. It comes in several flavors:
  * A native Mac OS X GUI application
  * GTK+ and Qt GUI applications for Linux, BSD, etc.
  * A headless daemon for servers and routers
  * A web UI for remote controlling any of the above

Visit https://transmissionbt.com/ for more information.

## Building

Transmission has an Xcode project file (Transmission.xcodeproj) for building in Xcode.

For a more detailed description, and dependencies, visit: https://github.com/transmission/transmission/wiki

### Building a Transmission release from the command line

    $ xz -d -c transmission-2.11.tar.xz | tar xf -
    $ cd transmission-2.11
    $ ./configure
    $ make
    $ sudo make install

### Building Transmission from the nightly builds

Download a tarball from https://build.transmissionbt.com/job/trunk-linux-inc/ and follow the steps from the previous section.

If you're new to building programs from source code, this is typically easier than building from SVN.

### Building Transmission from SVN (first time)

    $ svn co svn://svn.transmissionbt.com/Transmission/trunk Transmission
    $ cd Transmission
    $ ./autogen.sh
    $ make
    $ sudo make install

### Building Transmission from SVN (updating)

    $ cd Transmission
    $ make clean
    $ svn up
    $ ./update-version-h.sh
    $ make
    $ sudo make install

Notes for building on Solaris' C compiler: User av reports success with this invocation:

    ./configure CC=c99 CXX=CC CFLAGS='-D__EXTENSIONS__ -mt'
