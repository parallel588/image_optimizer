class ImageOptimizer
  class JPEGOptimizer
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def optimize
      return unless jpeg_format?

      if jpeg_optimizer_present?
        optimize_jpeg
      else
        warn 'Attempting to optimize a jpeg without jpegoptim installed. Skipping...'
      end
    end

  private

    def jpeg_format?
      ['jpeg', 'jpg'].include? extension(path)
    end

    def extension(path)
      path.split(".").last.downcase
    end

    def optimize_jpeg
      system "#{jpeg_optimizer_bin} -f --strip-all #{path}"
    end

    def jpeg_optimizer_present?
      !jpeg_optimizer_bin.nil? && !jpeg_optimizer_bin.empty?
    end

    def jpeg_optimizer_bin
      @jpeg_optimizer_bin ||= ENV['JPEGOPTIM_BIN'] || `which jpegoptim`.strip
    end

  end
end
