type mapping = Pattern_match.Set.t Dataflow_core.mapping
(** Map for each node/var whether a variable is "tainted" *)

type fun_env = (Dataflow_core.var, Pattern_match.Set.t) Hashtbl.t
(** Set of "tainted" functions in the overall program.
  * Note that here [Dataflow.var] is a string of the form "<source name>:<sid>". *)

type config = {
  is_source : AST_generic.any -> Pattern_match.t list;
  is_sink : AST_generic.any -> Pattern_match.t list;
  is_sanitizer : AST_generic.any -> Pattern_match.t list;
  found_tainted_sink :
    Pattern_match.Set.t -> Pattern_match.Set.t Dataflow_core.env -> unit;
}
(** This can use semgrep patterns under the hood. Note that a source can be an
  * instruction but also an expression. *)

val fixpoint : config -> fun_env -> IL.name option -> IL.cfg -> mapping
(** Main entry point, [fixpoint config fun_env opt_name cfg] returns a mapping
  * (effectively a set) containing all the tainted variables in [cfg]. Besides,
  * if it finds an instruction that consumes tainted data, then it will invoke
  * [config.found_tainted_sink] which can perform any side-effectful action.
  *
  * Parameter [fun_env] is a set of tainted functions in the overall program;
  * it provides basic interprocedural capabilities.
  *
  * Parameter [opt_name] is the name of the function being analyzed, if it has
  * a name. When [Some name] is given, and there is a tainted return statement in
  * [cfg], the function [name] itself will be added to [fun_env] by side-effect.
*)
