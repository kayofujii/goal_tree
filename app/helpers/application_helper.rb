module ApplicationHelper
    def current_user?(user)
        user == current_user
    end

    def full_title(page_title = '')
        base_title = 'tumiki'
        if page_title.empty?
            base_title
        else
            "#{page_title} | #{base_title}"
        end
    end

    def default_meta_tags
        {
            reverse: true,
            separator: '|',
            description: '挫折しない目標達成を支援するwebアプリです。使い方は3ステップで簡単。
                海外大学で実証されている目標達成フレームワークに沿って目標を登録、
                目標に向けた行動を記録して、ランクを上げていけば自然と目標達成ができます。',
            canonical: request.original_url,
            noindex: ! Rails.env.production?
        }
    end
    # metaタグ例
    # https://creat4869.hatenablog.com/entry/2019/08/15/170109
    # def default_meta_tags
    #     {
    #       site: 'サイト名',
    #       title: 'タイトル',
    #       reverse: true,
    #       separator: '|',
    #       description: 'ディスクリプション',
    #       keywords: 'キーワード',
    #       canonical: request.original_url,
    #       noindex: ! Rails.env.production?,
    #       icon: [
    #         { href: image_url('favicon.ico') },
    #         { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
    #       ],
    #       og: {
    #         site_name: 'サイト名',
    #         title: 'タイトル',
    #         description: 'ディスクリプション', 
    #         type: 'website',
    #         url: request.original_url,
    #         image: image_url('ogp.png'),
    #         locale: 'ja_JP',
    #       },
    #       twitter: {
    #         card: 'summary_large_image',
    #         site: '@ツイッターのアカウント名',
    #       }
    #       fb: {
    #         app_id: '自身のfacebookのapplication ID'
    #       }
    #     }
end
