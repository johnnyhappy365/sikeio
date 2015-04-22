class Course::FileReader

  attr_reader :version, :xml_file, :repo_dir, :course

  def initialize(course, version = nil)
    @course = course
    @version = version || course.current_version
    @xml_file = course.xml_file_path
    @repo_dir = course.repo_dir
  end

  def read_file
    result = nil
    if File.exist?(xml_file)
      result = read_xml_file
    else
      if File.exist?(repo_dir)
        parse_file
        result = read_xml_file
      end
    end
    result
  end

  private

  def read_xml_file
    File.open(xml_file) do |f|
      f.read
    end
  end

  def parse_file
    parse = Course::MdParse.new(course, version)
    f = File.new(xml_file, "w")
    f.write(parse.result)
    f.close
  end
end
