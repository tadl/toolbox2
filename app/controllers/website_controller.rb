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
            post['title']['rendered'] = p.css('.card-title').text.strip
            post['excerpt'] = {}
            post['excerpt']['rendered'] = p.css('.field-container').css('.field-container')[2].css('p').to_html
            post_url = p.css('.btn-primary').attr('href').to_s
            get_image_and_content = get_full_post(post_url)
            post['featured_image_urls'] = {}
            post['featured_image_urls']['thumbnail'] = get_image_and_content[0]
            post['content'] = {}
            post['content']['rendered'] = get_image_and_content[1]
            post['date'] = p.css('time').attr('datetime').to_s
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
        content = page.css('#block-website-theme-content').css('.field-container').css('p').to_html.gsub('href="/','href="https://www.tadl.org/' )
        return image, content
    end

end
