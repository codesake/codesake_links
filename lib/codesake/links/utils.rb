module Codesake

  module Links
    class Utils

      def self.print_str(url, logger, code, start, stop)
        logger.ok "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" if code == "200"
        logger.log "#{url}: #{str} (#{((stop-start) * 1000).round} msec)\n" unless code == "200"

        return
      end

      def self.print_code(url, logger, str, code, start, stop)
        logger.ok "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" if str == "Open"
        logger.err "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" if (str == "Closed" or str == "Non existent")
        logger.warn "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" if (str != "Closed" and str != "Non existent" and str != "Open")

        return
      end


    end
  end
end

