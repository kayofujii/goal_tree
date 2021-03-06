module ApplicationHelper
    def current_user?(user)
        user == current_user
    end

    def default_meta_tags
        {
            site: 'Tumiki ――挫折しない目標達成を支援するサービス',
            title: 'Tumiki（つみき）',
            reverse: true,
            separator: '|',
            description: '挫折しない目標達成を支援するwebアプリです。使い方は3ステップで簡単。
                海外大学で実証されている目標達成フレームワークに沿って目標を登録、
                目標に向けた行動を記録して、ランクを上げていけば自然と目標達成ができます。',
            canonical: request.original_url,
            noindex: ! Rails.env.production?,
            icon: [
                { href: image_url('apple-touch-icon.png') },
                { href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image' },
            ],
            og: {
                site_name: 'Tumiki ――挫折しない目標達成を支援するサービス',
                title: 'Tumiki（つみき）',
                description: '挫折しない目標達成を支援するwebアプリです。使い方は3ステップで簡単。
                    海外大学で実証されている目標達成フレームワークに沿って目標を登録、
                    目標に向けた行動を記録して、ランクを上げていけば自然と目標達成ができます。', 
                type: 'website',
                url: request.original_url,
                image: asset_url('apple-touch-icon.png'),
                locale: 'ja_JP',
            },
            twitter: {
                card: 'summary',
                site: '@munchkayo1025',
            }
        }
    end
end
