module Codesake

  module Links
    class Utils

      def self.print_str(url, logger, str, start, stop)
        logger.ok "#{url}: #{str} (#{((stop-start) * 1000).round} msec)" if str == "Open"
        logger.log "#{url}: #{str} (#{((stop-start) * 1000).round} msec)" unless str == "Open"

        return
      end

      def self.print_code(url, logger, code, start, stop)
        logger.ok "#{url}: #{code} (#{((stop-start) * 1000).round} msec)" if code == "200"
        logger.warn "#{url}: #{code} (#{((stop-start) * 1000).round} msec)" unless code == "200"

        return
      end


    end
  end
end

