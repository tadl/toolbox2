class WebsiteController < ApplicationController
    before_action :set_headers

    def posts

        @posts = Rails.cache.fetch('posts')
        if @posts.nil?
            @posts = []

            agent = Mechanize.new
            page = agent.get('https://www.tadl.org/posts?field_bl_type_target_id%5B294%5D=294')
            post_blocks = page.css('.card')

            post_blocks.first(6).each do |p|
                post = {}
                post['title'] = {}
                post['title']['rendered'] = p.css('a').text.strip
                post['post_url'] = 'https://www.tadl.org' + (p.css('a').attr('href').to_s)
                get_image_date_and_content = get_full_post(post['post_url'])
                post['featured_image_urls'] = {}
                post['featured_image_urls']['thumbnail'] = get_image_date_and_content[0]
                post['content'] = {}
                post['content']['rendered'] = get_image_date_and_content[1].to_html.gsub('href="/','href="https://www.tadl.org/' ).gsub('src="/','src="https://www.tadl.org/')
                post['content']['text'] = ActionView::Base.full_sanitizer.sanitize(post['content']['rendered'])
                post['excerpt'] = {}
                post['excerpt']['rendered'] = ActionController::Base.helpers.truncate_html(post['content']['rendered'], length: 200, omission: '...')
                post['date'] = get_image_date_and_content[2]
                @posts.push(post)
            end
        end
        respond_to do |format|
            format.json {render json: @posts.to_json}
        end
    end

    def mobile_events
        venue = params[:venue]
        if venue.nil? || venue == 'all'
            @events = Rails.cache.fetch('events_all')
        else
            @events = Rails.cache.fetch(('events_' + venue))
        end
        respond_to do |format|
            format.html
            format.json {render json: @events.to_json}
        end
    end

    private

    def get_full_post(url)
        agent = Mechanize.new
        page = agent.get(url)
        partial_image = page.css('.blog-featured-img').css('img')[0].attr('src') rescue nil
        image = 'https://www.tadl.org' + partial_image
        content = page.css('#block-website-theme-content').css('.field-container')[2]
        date = page.css('time').attr('datetime').to_s
        return image, content, date
    end

end
