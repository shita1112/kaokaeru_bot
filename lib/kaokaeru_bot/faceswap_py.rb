class FaceswapPy < BaseCommand
  def extract(*args)
    python(faceswap_path, "extract", *args)
  end

  def train(*args)
    python(faceswap_path, "train", *args)
  end

  def convert(*args)
    python(faceswap_path, "convert", *args)
  end

  def effmpeg(*args)
    python(tools_pagh, "effmpeg", *args)
  end

  def sort(*args)
    python(tools_pagh, "sort", *args)
  end

  def train_with_timeout(time, *args)
    # run("timeout", time, "python", faceswap_path, "train", *args) { puts "finish train" }

    command = Shellwords.join(["python", faceswap_path, "train", *args].compact)
    pid = Process.spawn(command)
    sleep time
    Process.kill(:INT, pid)
    sleep 10
  end

  def faceswap_path
    KaokaeruBot::DEEP_ROOT.join("faceswap_code", "faceswap_latest", "faceswap.py").freeze
  end

  def tools_pagh
    KaokaeruBot::DEEP_ROOT.join("faceswap_code", "faceswap_latest", "tools.py").freeze
  end

end
