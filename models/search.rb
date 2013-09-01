module YoutubeDL
	class Search

		attr_reader :query, :lang

		def initialize(params = {})
			raise ArgumentError.new("Missing parameters") if params.nil? || params.empty?

			@query = params.fetch("query")
			@lang  = params.fetch("lang")  { 'en' }
		end

		def results
      client.videos_by(
        :query    => query,
        :hl       => lang,
        :per_page => 50
      ).videos
		end


		private

		def client
			@client ||= YouTubeIt::Client.new
		end
	end
end
