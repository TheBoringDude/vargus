# vargus

Simple [Experimental] Commander for VLANG

## Usage

- Creating a root commander instance

```v
root := vargus.CmdConfig{
    command: 'root'
    short_desc: 'short desc'
    long_desc: 'some long description'
    function: fn (args []string, flags []vargus.FlagArgs) {
        println('hi')
    }
}

mut cmder := vargus.new(root)
```

All commands created with new are automatically defined as main root.

- Adding sub commands (`[parent_command].add_command(CmdConfig)`)

You can only add commands and sub_commands once a `root` command is defined.

```
mut generate := cmder.add_command(
    command: 'generate'
    short_desc: 'generate  desc'
    long_desc: 'generate some long description'
    function: fn (args []string, flags []vargus.FlagArgs) {
        println('generate command')
    }
)
```

NoTe: if you want to add sub_commands or flags to a command, you should pass it to a variable. If not, you can just ignore the variable and just call the function `add_command`

### &copy; TheBoringDude
