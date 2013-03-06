#!/usr/bin/env ruby

FSCRIPT_PATH = "/Library/Frameworks/FScript.framework"

GDB = IO.popen("gdb", "w")
def gdb(cmd)
    GDB.puts cmd
    GDB.flush
end

updaterScript = <<END_OF_FSCRIPT
SkypeMenuUpdater : NSObject
{
    statusBarItem
    timer

    - init
    {
        self := super init.
        self ~~ nil ifTrue:
        [
            statusBarItem := NSStatusBar systemStatusBar statusItemWithLength:20.

            timer := NSTimer scheduledTimerWithTimeInterval:1
                                                     target:[self updateMenu]
                                                   selector:#value
                                                   userInfo:nil
                                                    repeats:YES.
        ].
        ^ self
    }

    - updateMenu
    {
        statusBarItem setTitle:NSApplication sharedApplication dockTile badgeLabel.
    }
}.

updater := (SkypeMenuUpdater alloc) init.
END_OF_FSCRIPT

updaterScript.gsub!("\n", "\\n")

gdb "attach Skype"
gdb "p (char)[[NSBundle bundleWithPath:@\"#{FSCRIPT_PATH}\"] load]"
gdb "p (void)[[FSInterpreter interpreter] execute:@\"#{updaterScript}\"]"
gdb "detach"
gdb "quit"

GDB.close
