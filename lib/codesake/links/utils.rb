module Codesake

  module Links
    class Utils

      def self.print_str(url, logger, str, start, stop)
        logger.ok "#{url}: #{str} (#{((stop-start) * 1000).round} msec)\n" if str == "Open"
        logger.log "#{url}: #{str} (#{((stop-start) * 1000).round} msec)\n" unless str == "Open"

        return
      end

      def self.print_code(url, logger, code, start, stop)
        logger.ok "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" if code == 200
        logger.log "#{url}: #{code} (#{((stop-start) * 1000).round} msec)\n" unless code == 200

        return
      end


    end
  end
end

