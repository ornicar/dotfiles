shellPrompt := {
  (state: State) ⇒ "%s> ".format(Project.extract(state).currentProject.id)
}

com.dscleaver.sbt.SbtQuickFix.QuickFixKeys.vimExecutable := "vim"

com.dscleaver.sbt.SbtQuickFix.QuickFixKeys.vimEnableServer := false
