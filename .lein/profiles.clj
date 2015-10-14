{:user
  {:repl-options
    {:prompt (fn [ns] (str "(ns " ns ") λ "))}
    :plugins [[mvxcvi/whidbey "1.0.0"]]
      :whidbey
      {:color-scheme
        {:delimiter       nil
         :tag             [:red]
         :nil             [:bold :black]
         :boolean         [:bold :blue]
         :number          [:magenta]
         :string          [:bold :green]
         :character       [:bold :green]
         :keyword         [:bold :yellow]
         :symbol          [:bold :cyan]
         :function-symbol [:bold :red]
         :class-delimiter [:blue]
         :class-name      [:bold :yellow]}}}}
