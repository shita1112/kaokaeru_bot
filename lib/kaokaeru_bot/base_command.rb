class BaseCommand
  include Rake::FileUtilsExt

  def run(*args)
    command = Shellwords.join(args.compact)

    puts "$ #{command}"

    if block_given?
      system(command)
      yield
    else
      is_ok = system(command)
      raise "command failed" unless is_ok
    end
  end

  def simple_run(command)
    puts "$ #{command}"
    system(command)
  end

  def python(*args)
    run("python", *args)
  end

  def self.method_missing(method, *args, &block)
    new.send(method, *args, &block)
  end
end
