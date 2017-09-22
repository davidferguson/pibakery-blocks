#!/usr/bin/python

import sys


CMDLINETXT="/boot/cmdline.txt" # Filename that contains the kernel command line

def read_cmdline(filename=CMDLINETXT):
    '''
    Read the command line from the file.  This can only ever be a single line,
    so this function only reads the first line.  Return value is the command
    line as a string, with leading/trailing whitespace stripped.
    '''
    with open(filename, "r") as f:
        cmdline = f.readline().strip()
    return cmdline

def write_cmdline(cmdline="", filename=CMDLINETXT):
    '''
    Write a new commandline to the file, overwriting the existing contents.
    This can only ever be a single line, so this function only writes one.
    The new command line has leading and trailing whitespaces stripped before
    writing.  Return is always True.
    '''
    with open(filename, "w") as f:
        f.write("%s\n" % cmdline.strip())
    return True

#### MAIN ####

# Make sure we've at least been given a new_key, since this is the minimum
# amount of info we need in order to do something useful. If not, just exit.
if not len(sys.argv) > 1:
    print "ERROR: No kernel keyword given. Exiting."
    sys.exit(-1)

# Parse (haha, not so much) command line arguments
new_key = sys.argv[1]
new_value = sys.argv[2]
multi = sys.argv[3]


# Construct the new command.  If we've specified both a keyword and a value,
# then new_cmd will look like "key=value". otherwise it'll just be a single
# keyoard.
if len(new_value) > 0:
    new_cmd = "%s=%s" % (new_key, new_value)
else:
    new_cmd = new_key

cmdline = read_cmdline()

# If we allow multiple values for this keyword, we can just append the new
# command to the end of the string.  Useful if, for example, we're adding
# an additional 'console' parameter or something similar.
if multi == "Yes":
    new_cmdline = cmdline + " " + new_cmd
else:
    # Split the commandline into individual commands (keyword or keyword=value
    # pairs).
    cmds = cmdline.split(' ')

    # make a copy of the original commands, which we'll edit and later
    # output as the new command line.
    new_cmds = list(cmds) # make a true copy, not a reference
    replaced = False # keeps track of whether we replaced the existing command yet

    # Iterate through all the commands in the old command line
    for cmd in cmds:
        # Split each command into the key and the value around the '='.  Just
        # in case we ever see a value with an embedded '=', we limit the split
        # to just the first occurrence.
        elements = cmd.split('=', 1)
        key = elements[0] # we only care what command we found, not the value

        if (key == new_key):
            # If we found the command we're supposed to operate on, remove it
            # from the new command line.  Replace it with the new value,
            # unless we've already replaced it once.
            new_cmds.remove(cmd)
            if not replaced:
                # Make sure we only append this new command once, no matter
                # how many times we found it in the original cmdline
                new_cmds.append(new_cmd)
                replaced = True


    # If we still haven't replaced the cmd, it means the command wasn't found
    # in the original string, so we can just append it.
    if not replaced:
        new_cmds.append(new_cmd)

    new_cmdline = ' '.join(new_cmds)

# Write out the new commandline to the file
write_cmdline(new_cmdline)
