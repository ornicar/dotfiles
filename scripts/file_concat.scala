import java.io._

object FileConcat {
  def main(args: Array[String]) {
    val (ext, dir) = args.toList match {
      case Nil => sys.error("No extension specified")
      case List(ext) => (ext, ".")
      case List(ext, dir) => (ext, dir)
      case _ => sys.error("Too many arguments")
    }
    val filter: File => Boolean = (f => f.getName.endsWith(ext))
    val files = walkDir(new File(dir), filter)
    def content(file: File): String = io.Source.fromFile(file.getAbsolutePath).mkString
    val text = files.map(content).mkString("\n")
    print(text)
  }

  private[this] def walkDir(file: File, filter: File => Boolean): List[File] = file match {
    case f if (f.isDirectory) => f.listFiles.toList flatMap (walkDir(_, filter))
    case f if (filter(file)) => List(file)
    case f => Nil
  }
}
