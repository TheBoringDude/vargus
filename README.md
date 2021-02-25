# vargus

A Simple [Experimental] Commander for VLANG that just works

## Usage

### Creating a root commander instance

```v
root := vargus.CmdConfig{
    command: 'root'
    short_desc: 'short desc'
    long_desc: 'some long description'
    allow_next_args: true
    function: fn (args []string, flags []vargus.FlagArgs) {
        println('hi')
    }
}

mut cmder := vargus.new(root)
```

- `allow_next_args` : arguments will be allowed next to a command if it isn't in the command's sub_commands. If set to `false` it will consider arguments next to the command unknown but will be considered as `args` if there are no flags defined.

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

### Custom Configurations

**WARNING**: These configurations are persistent that once defined on a command, will take effect on each sub_commands. It is preferred to be set on a root / main command.

- #### Command Help
  ````v
  [command].set_help(fn (command string, desc string, sub_commands []vargus.HelpSubcommands, local_flags []vargus.FlagArgs, global_flags []vargus.FlagArgs))```
  ````
- #### Flag Validators
  ```v
  [command].set_validator(cf CFlagValidatorConfig)
  ```
  ```v
  pub struct CFlagValidatorConfig {
      flag_type FlagDataType [required]
      function fn (x string) bool [required]
  }
  ```
- #### Custom Errors
  - **Required** : flags that are required / a value should be set
    ```v
    [command].set_custom_err_required(f fn (x string, y string))
    ```
  - **Value** : the value set to the flag is invalid or of different data type
    ```v
    [command].set_custom_err_value(f fn (x string, y string))
    ```
  - **Blank** : the flag is present but no value can be found
    ```v
    [command].set_custom_err_blank(f fn (x string))
    ```
  - **Unknown** : flag is unknown or is not set to the command
    ```v
    [command].set_custom_err_unknown(f fn (x string))
    ```
  - **Command** : the command is unknown
    ```v
    [command].set_custom_err_command(f fn (x string))
    ```

### Settings configurations directly from struct

Others prefer directly configuring a command in the struct.

- **CmdConfig** : this is the main config in adding new commands

  ```v
  pub struct CmdConfig {
      command    string
      short_desc string
      long_desc  string
      allow_next_args bool	= true // defaults to true
      function   fn (args []string, flags []FlagArgs)
      hooks CmdHooksConfig
      config CommandCmdConfig
  }
  ```

  ```v
  pub struct CommandCmdConfig {
      help        fn (command string, desc string, sub_commands []HelpSubcommands, local_flags []FlagArgs, global_flags []FlagArgs)
      errors      CmdErrorsConfig
      validators  CmdValidatorsConfig
  }

  pub struct CmdErrorsConfig {
      required fn (flag_name string, flag_shortarg string)
      value    fn (flag string, flag_type string)
      blank    fn (flag string)
      unknown  fn (flag string)
      command  fn (command string)
  }

  pub struct CmdValidatorsConfig {
      integer     fn (flag_value string) bool
      string_var  fn (flag_value string) bool
      float       fn (flag_value string) bool
      boolean     fn (flag_value string) bool
  }
  ```

## TODO:

- Minimize / control memory leaks. (`vargus` leaks too much memory on `valgrind`) [need help]
- Add more features...
- Simplify codes for minimal CLI app output.

## How does it work?

`vargus` utilizes only the `os` module, primarily the `os.args`

- Each argument (string) from the `os.args` is manually parsed. How?
  Sample `os.args` = `['home/app', 'generate', '--flag', 'flagvalue', 'args']`
  - `home-app` is the main executable
  - If `generate` has been defined as a command, it will call the `command`'s function, otherwise it will be parsed as an `argument` and it will call the parent function.

* #### Unknown commands
  - For `vargus` to be able to know that a command is unknown, you should set the `allow_next_args` in the command's `CmdConfig` to false. This will set the next argument to a command `unknown` if the preceeding argument is a flag. Otherwise, it will be parsed as an argument.

## Inspirations:

- [**Cobra**](https://cobra.dev) CLI Commander for Go

### &copy; TheBoringDude
