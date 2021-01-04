defmodule Shlinkedin.Badges do
  alias Shlinkedin.Profiles.Profile
  alias Shlinkedin.Profiles
  import Phoenix.LiveView.Helpers

  def profile_badges(socket, %Profile{} = profile, size \\ 4) do
    is_featured(socket, Profiles.list_awards(profile), size)
  end

  defp is_featured(assigns, awards, size) do
    ~L"""
    <div class="inline-flex align-baseline">

    <%= for award <- awards do %>
    <div class="inline-flex tooltip <%= award.award_type.color %>">

    <%= if award.award_type.image_format == "svg" do  %>
        <svg class="w-<%= size %> h-<%= size %> " fill="currentColor" viewBox="0 0 20 20"
            xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="<%= award.award_type.fill%>" d="<%= award.award_type.svg_path %>"
                clip-rule="<%= award.award_type.fill%>">
            </path>
        </svg>
    <% else %>
    <span class="text-sm">
    <%= award.award_type.emoji %>
    </span>

    <% end %>
        <span class="tooltip-text -mt-8"><%= award.award_type.description %></span>
    </div>

    <% end %>

    </div>

    """
  end
end
