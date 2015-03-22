ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    columns do
        column do
            panel "Recent Orders" do
                table_for Order.where(status: [0,1]).order("created_at desc").limit(20) do
                    column "Order ID" do |order|
                        link_to order.orderid, admin_order_path(order)
                    end
                    column :emailused
                    column :user
                    column :created_at
                    column "Status", :statustext
                end
            end
        end
        column do
            panel "New Users" do
                table_for User.order("created_at desc").limit(20) do
                    column :name
                    column :email
                    column :created_at
                end
            end
        end

    end

  end # content
end
