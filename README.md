# vargus

A Simple [Experimental] Commander for VLANG that just works

## Usage

### Creating a root commander instance

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

All commands created with `vargus.new()` are automatically defined as main root command.

#### Info: You cannot explicitly add sub_commands or flags directly from structs. All actions are done through functions.

### Adding sub commands (`[parent_command].add_command(CmdConfig)`)

You can only add commands and sub_commands once a `root` command is defined.

```v
mut generate := cmder.add_command(
    command: 'generate'
    short_desc: 'generate  desc'
    long_desc: 'generate some long description'
    function: fn (args []string, flags []vargus.FlagArgs) {
        println('generate command')
    }
)
```

NoTe: if you want to add sub_commands or flags to a command, you should pass it to a variable. If not, you can just ignore the variable and just call the function `[parentcommand].add_command`

### Adding flags

Vargus supports adding local and global flags.

- **Flag Configurations**

  - IntFlagConfig

  ```v
  pub struct IntFlagConfig {
      name string
      short_arg string
      required bool
      default_value int
      help string
  }
  ```

  - StringFlagConfig

  ```v
  pub struct StringFlagConfig {
      name string
      short_arg string
      required bool
      default_value string
      help string
  }
  ```

  - FloatFlagConfig

  ```v
  pub struct FloatFlagConfig {
      name string
      short_arg string
      required bool
      default_value f32
      help string
  }
  ```

  - BoolFlagConfig

  ```v
  pub struct BoolFlagConfig {
      name string
      short_arg string
      required bool
      default_value bool
      help string
  }
  ```

#### Local Flags

- `[command].add_local_flag_int(fc IntFlagConfig)`
- `[command].add_local_flag_string(fc StringFlagConfig)`
- `[command].add_local_flag_float(fc FloatFlagConfig)`
- `[command].add_local_flag_bool(fc BoolFlagConfig)`

#### Global Flags

- `[command].add_global_flag_int(fc IntFlagConfig)`
- `[command].add_global_flag_string(fc StringFlagConfig)`
- `[command].add_global_flag_float(fc FloatFlagConfig)`
- `[command].add_global_flag_bool(fc BoolFlagConfig)`

### Adding Command Hooks (`[command].add_hooks(HooksConfig)`)

Vargus supports adding hooks to your command.

**\*pre-run** hooks will be run before executing the command function

**\*post-run** hooks will be run after the execution of the command function

- **HooksConfig**
  ```v
  pub struct HooksConfig {
      hooks_type      CmdHooksType
      function        fn (x []string, y []FlagArgs)
  }
  ```
- **CmdHooksType**
  ```v
  enum CmdHooksType {
      pre_run
      post_run
      persistent_pre_run
      persistent_post_run
  }
  ```

## How does it work?

`vargus` utilizes only the `os` module, primarily the `os.args`

### &copy; TheBoringDude
