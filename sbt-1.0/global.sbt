shellPrompt := {
  (state: State) ⇒ "%s> ".format(Project.extract(state).currentProject.id)
}

Global / onChangedBuildSource := ReloadOnSourceChanges

import sbt.errorssummary.Plugin.autoImport._
reporterConfig := reporterConfig.value.withColumnNumbers(true)
reporterConfig := reporterConfig.value.withReverseOrder(false)
reporterConfig := reporterConfig.value.withColors(false)
reporterConfig := reporterConfig.value.withShowLegend(false)
