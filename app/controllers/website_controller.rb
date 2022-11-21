class WebsiteController < ApplicationController
    before_action :set_headers

    def posts
        @posts = []

        agent = Mechanize.new
        page = agent.get('https://www.tadl.org/posts?field_bl_type_target_id%5B294%5D=294')
        post_blocks = page.css('.card')

        post_blocks.first(5).each do |p|
            post = {}
            post['title'] = {}
            post['title']['rendered'] = p.css('a').text.strip
            post_url = p.css('a').attr('href').to_s
            get_image_date_and_content = get_full_post(post_url)
            post['featured_image_urls'] = {}
            post['featured_image_urls']['thumbnail'] = get_image_date_and_content[0]
            post['content'] = {}
            post['content']['rendered'] = get_image_date_and_content[1].to_html.gsub('href="/','href="https://www.tadl.org/' ).gsub('src="/','href="https://www.tadl.org/')
            post['excerpt'] = {}
            post['excerpt']['rendered'] = ActionController::Base.helpers.truncate_html(post['content']['rendered'], length: 200, omission: '...')
            
            post['date'] = get_image_date_and_content[2]
            @posts.push(post)
        end

        respond_to do |format|
            format.json {render json: @posts.to_json}
        end
    end

    private

    def get_full_post(url)
        full_url = 'https://www.tadl.org' + url
        agent = Mechanize.new
        page = agent.get(full_url)
        partial_image = page.css('.blog-featured-img').css('img')[0].attr('src') rescue nil
        image = 'https://www.tadl.org' + partial_image
        content = page.css('#block-website-theme-content').css('.field-container')[2]
        date = page.css('time').attr('datetime').to_s
        return image, content, date
    end

end
