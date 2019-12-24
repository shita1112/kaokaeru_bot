# KaokaeruBot::FaceChanger.new(mention).create_image
class KaokaeruBot
  class FaceChanger
    include ::Rake::FileUtilsExt

    # TRAIN_TIME = 50.minutes # 90%
    # TRAIN_TIME = 20.minutes # 80%
    TRAIN_TIME = 5.minutes # 70%

    DETECTOR = "mtcnn"
    SAVE_INTERVAL = 100 # batchサイズが1なので、高速
    GPUS = 1

    def initialize(mention)
      @mention = mention
      @face = mention.face
    end

    def change_face
      setup

      extract
      train
      convert
    end

    private

    def setup
      set_pathname
      clean_dir
      mkdirs
      copy_models
    end

    def set_pathname
      @deep_root = KaokaeruBot::DEEP_ROOT
      @kaosdir = @deep_root.join("kaodir")
      @kaodir = @kaosdir.join(@mention.id)
      @original_models = @deep_root.join("model_image",  @face.type, "#{@face.trainer}_models")
      @b_faces = @deep_root.join("model_image",  @face.type, "images")
      @models = @kaodir.join("models")
      @a_images = @kaodir.join("a_images")
      @a_image = @a_images.join("original_face.jpeg")
      @a_faces = @kaodir.join("a_faces")
      @df = @kaodir.join("df")
    end

    def clean_dir
      @kaodir.rmtree if @kaodir.exist?
    end

    def mkdirs
      mkdir(@kaodir)
      mkdir(@a_images)
    end

    def copy_models
      cp_r(@original_models, @models)
    end

    def extract
      download_original_face
      faceswap_extract
    end

    def download_original_face
      File.write(@a_image, @mention.original_face, mode: "wb")
    end

    def faceswap_extract
      FaceswapPy.extract(
        "--input-dir", @a_images,
        "--output-dir", @a_faces,
        "--detector", DETECTOR,
        # "--skip-existing",
        # "--skip-existing-faces"
      )
    end

    def train
      set_batch_size
      train_model
    end

    def set_batch_size
      # 1しか無理なはず
      @batch_size = 1
    end

    def train_model
      FaceswapPy.train_with_timeout(
        TRAIN_TIME,
        "--input-A", @a_faces,
        "--input-B", @b_faces,
        "--model-dir", @models,
        "--trainer", @face.trainer,
        "--batch-size", @batch_size,
        "--save-interval", SAVE_INTERVAL,
        "--gpus", GPUS
      )
    end

    def convert
      FaceswapPy.convert(
        "--model-dir", @models,
        "--input-dir", @a_images,
        "--output-dir", @df,
        "--trainer", @face.trainer,
        "--gpus", GPUS,
        # "--smooth-box",
        # "--avg-color-adjust",
        # "--erosion-size", "12",
        # "--blur-size", "12",
        # "--seamless",
        "--color-adjustment", "avg-color"
      )
    end
  end
end
