
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/davidg/.travis/travis.sh ] && source /Users/davidg/.travis/travis.sh

#
# Import.io
#

IMPORT_IO_RC=$HOME/.import-io
[ -r "$IMPORT_IO_RC" ] && source "$IMPORT_IO_RC"


IMPORT_IO_FUNC=$HOME/.import-io.sh
[ -r "$IMPORT_IO_FUNC" ] && source "$IMPORT_IO_FUNC"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
