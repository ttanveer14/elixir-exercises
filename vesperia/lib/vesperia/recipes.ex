defmodule Vesperia.Recipes do
  def recipes do
    %{
      okonomiyaki: %{
        cabbage: 1,
        egg: 1,
        meat: 1,
        shrimp: 1,
        squid: 1,
        sticky_flour: 1
      },
      minestrone_soup: %{onion: 1, tomato: 1},
      pudding: %{egg: 1, milk: 1},
      cream_stew: %{carrot: 1, chicken: 1, milk: 1, onion: 1, potato: 1},
      beef_bowl: %{beef: 1, onion: 1, rice: 1},
      omelette_rice: %{chicken: 1, egg: 1, onion: 1, rice: 1},
      miso_soup: %{miso: 1, radish: 1, tofu: 1},
      tempura: %{
        chicken: 1,
        egg: 1,
        shrimp: 1,
        squid: 1,
        sticky_flour: 1,
        vegetable: 1
      },
      rice_ball: %{dried_seaweed: 1, rice: 1, salmon: 1},
      mabo_curry: %{onion: 1, potato: 1, rice: 1, tofu: 1, tomato: 1},
      sashimi: %{mackerel: 1, salmon: 1, scallop: 1, squid: 1, tuna: 1},
      fruit_parfait: %{egg: 1, fruit: 4, milk: 1},
      pork_miso_soup: %{carrot: 1, miso: 1, pork: 1, tofu: 1},
      meat_sauce: %{onion: 1, pork: 1, sticky_flour: 1, tomato: 1},
      scottish_egg: %{egg: 1, meat: 1, tomato: 1},
      vichyssoise: %{milk: 1, potato: 1, sticky_flour: 1},
      salad: %{cucumber: 1, lettuce: 1, tomato: 1},
      sandwich: %{bread: 1, egg: 1},
      soup_noodles: %{cabbage: 1, carrot: 1, onion: 1, pork: 1, sticky_flour: 1},
      salisbury_steak: %{beef: 1, egg: 1, onion: 1},
      japanese_stew: %{kelp: 1, radish: 1, squid: 1},
      fried_chicken_and_fries: %{chicken: 1, potato: 1},
      clam_chowder: %{onion: 1, potato: 1, scallop: 1},
      croquette: %{meat: 1, onion: 1, potato: 1},
      cake: %{egg: 1, milk: 1, strawberry: 1},
      vegetable_stiry_fry: %{carrot: 1, cucumber: 1, meat: 1, onion: 1},
      seafood_bowl: %{
        cucumber: 1,
        rice: 1,
        salmon: 1,
        scallop: 1,
        shrimp: 1,
        tuna: 1
      },
      fish_with_miso_sauce: %{mackerel: 1, miso: 1, rice: 1},
      crepe: %{banana: 1, egg: 1, kiwifruit: 1, milk: 1},
      sushi: %{dried_seaweed: 1, fish: 3, kelp: 1, rice: 1},
      udon_noodles_hot_pot: %{
        egg: 1,
        napa_cabbage: 1,
        shiitake: 1,
        shrimp: 1,
        squid: 1,
        sticky_flour: 1
      },
      sorbet: %{fruit: 1, milk: 1},
      pork_stew: %{kelp: 1, pork: 1, radish: 1},
      sukiyaki: %{beef: 2, egg: 1, napa_cabbage: 1, shiitake: 1, tofu: 1},
      kebab_sandwich: %{beef: 1, bread: 1, lettuce: 1, tomato: 1},
      curry: %{carrot: 1, meat: 1, onion: 1, potato: 1, rice: 1}
    }
  end
end
