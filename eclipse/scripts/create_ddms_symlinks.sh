#!/bin/bash
#----------------------------------------------------------------------------|
# Creates the links to use ddm{ui}lib in the eclipse-ide plugin.
# Run this from sdk/eclipse/scripts
#----------------------------------------------------------------------------|

set -e

HOST=`uname`

if [ "${HOST:0:6}" == "CYGWIN" ]; then
    PLATFORM="windows-x86"

    # We can't use symlinks under Cygwin

    function cpfile { # $1=dest $2=source
        cp -fv $2 $1/
    }

    function cpdir() { # $1=dest $2=source
        rsync -avW --delete-after $2 $1
    }

else
    if [ "$HOST" == "Linux" ]; then
        PLATFORM="linux-x86"
    elif [ "$HOST" == "Darwin" ]; then
        PLATFORM="darwin-x86"
    else
        echo "Unsupported platform ($HOST). Nothing done."
    fi

    # For all other systems which support symlinks

    # computes the "reverse" path, e.g. "a/b/c" => "../../.."
    function back() {
        echo $1 | sed 's@[^/]*@..@g'
    }

    function cpfile { # $1=dest $2=source
        ln -svf `back $1`/$2 $1/
    }

    function cpdir() { # $1=dest $2=source
        ln -svf `back $1`/$2 $1
    }
fi

# CD to the top android directory
D=`dirname "$0"`
cd "$D/../../../"

BASE="sdk/eclipse/plugins/com.android.ide.eclipse.ddms"
DEST=$BASE/libs

mkdir -p $DEST
for i in prebuilt/common/jfreechart/*.jar; do
  cpfile $DEST $i
done

LIBS="ddmlib ddmuilib"
echo "make java libs ..."
make -j3 showcommands $LIBS || die "DDMS: Fail to build one of $LIBS."

for LIB in $LIBS; do
    cpfile $DEST out/host/$PLATFORM/framework/$LIB.jar
done
