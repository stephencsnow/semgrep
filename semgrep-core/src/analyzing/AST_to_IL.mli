val name_of_entity : AST_generic.entity -> IL.name option

val stmt : Lang.t -> AST_generic.stmt -> IL.stmt list

val function_definition :
  Lang.t -> AST_generic.function_definition -> IL.function_definition

val program : Lang.t -> AST_generic.program -> IL.program
