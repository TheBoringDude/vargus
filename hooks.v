module vargus

enum CmdHooksType {
	pre_run
	post_run
	persistent_pre_run
	persistent_post_run
}

// CmdHooks are command hooks run specifically only on
//   specific command target / on which it is set.
struct CmdHooks {
mut:
	use_pre_run bool
	use_post_run bool
	pre_run fn (x []string, y []FlagArgs)
	post_run fn (x []string, y []FlagArgs)
}

// Config required to be passed for adding hooks
pub struct HooksConfig {
	hooks_type CmdHooksType
	function fn (x []string, y []FlagArgs)
}

// PersistentCmdHooks are command hooks that will run
//   on the command and all of it's sub_command if not defined.
struct PersistentCmdHooks {
mut:
	use_persistent_pre_run bool
	use_persistent_post_run bool
	persistent_pre_run fn (x []string, y []FlagArgs)
	persistent_post_run fn (x []string, y []FlagArgs)
}

// add_hooks adds the capability to add hooks to a command
pub fn (mut c Commander) add_hooks(h_cfg HooksConfig) {
	match h_cfg.hooks_type {
		.pre_run {
			c.hooks.use_pre_run = true
			c.hooks.pre_run = h_cfg.function
		}
		.post_run {
			c.hooks.use_post_run = true
			c.hooks.post_run = h_cfg.function
		}
		.persistent_pre_run {
			c.persistent_hooks.use_persistent_pre_run = true
			c.persistent_hooks.persistent_pre_run = h_cfg.function
		}
		.persistent_post_run {
			c.persistent_hooks.use_persistent_post_run = true
			c.persistent_hooks.persistent_post_run = h_cfg.function
		}
	}
}

// get_persistent_hooks parses the persistent hooks if it is defined in the command
//   otherwise, it uses the parent's
fn (c &Commander) get_persistent_hooks(parent_phooks PersistentCmdHooks) PersistentCmdHooks {
	mut tp_hooks := parent_phooks

	// if persistent_pre_run is defined in cmd, use it
	//   otherwise use the defined one by the parent
	if c.persistent_hooks.use_persistent_pre_run {
		tp_hooks.use_persistent_pre_run = c.persistent_hooks.use_persistent_pre_run
		tp_hooks.persistent_pre_run = c.persistent_hooks.persistent_pre_run
	}

	// if persistent_post_run is defined in cmd, use it
	//   otherwise use the defined one by the parent
	if c.persistent_hooks.use_persistent_post_run {
		tp_hooks.use_persistent_post_run = c.persistent_hooks.use_persistent_post_run
		tp_hooks.persistent_post_run = c.persistent_hooks.persistent_post_run
	}


	return tp_hooks
}