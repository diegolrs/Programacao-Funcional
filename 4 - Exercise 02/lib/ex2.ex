defmodule Ex2 do
  @moduledoc "Codigo para o Exercicio 2 de LPIII - Programacao Funcional"

  @doc "Retorna o terceiro elemento da lista l, ou nil caso l tenha menos de 3 elementos."
  def terceiro([]), do: nil
  def terceiro([_]), do: nil
  def terceiro([_h1 | [_h2 ]]), do: nil
  def terceiro([_h1 | [_h2 | [h3 | _h4]]]), do: h3

  @doc "Obtem o tamanho da lista l"
  def tamanho([]), do: 0
  def tamanho([_ | t]), do: 1 + tamanho(t)

  def elemento_n([], _n), do: nil
  def elemento_n([x | _], 0), do: x
  def elemento_n([_ | r], n), do: elemento_n(r, n-1)

  # Um tipo comum de processamento de lista e' calcular um resultado levando
  # em consideracao todos os elementos da lista, por exemplo a soma ou
  # produto de uma lista de numeros.

  @doc "Calcula a soma dos numeros da lista l."
  def soma_lista([]), do: 0
  def soma_lista([h | t]), do: h + soma_lista(t)

  @doc "Calcula o produto dos numeros da lista l."
  def mult_lista([]), do: 1
  def mult_lista([h | t]), do: h * mult_lista(t)

  # Opcional: escreva uma versao de mult_lista que retorne zero assim que
  # encontrar um elemento 0 na lista, sem precisar ir ate' o fim da lista
  # e efetuar todas as multiplicacoes.

  @doc "Retorna uma string que e' a concatenacao de todas as strings na lista ls."
  def concat_lista([]), do: ""
  def concat_lista([h | t]), do: h <> concat_lista(t)

  @doc "Retorna o maior numero em uma lista de numeros (nil se a lista for vazia)."
  def max_lista([]), do: nil
  def max_lista([x]), do: x
  def max_lista([h | t]), do: max(h, max_lista(t))

  # As vezes podemos querer uma parte dos elementos da lista, sejam
  # os primeiros ou ultimos.

  @doc """
  Retorna os primeiros n elementos da lista l.
  Se l tem n elementos ou menos, retorna a lista inteira.

  Exemplo:
  iex> Ex2.primeiros_n([1, 2, 3, 4], 2)
  [1, 2]
  """
  def primeiros_n([], _n), do: []
  def primeiros_n(_, 0), do: []
  def primeiros_n([h | t], n), do: [h | primeiros_n(t, n-1)]

  @doc """
  Retorna os ultimos n elementos da lista l.
  Se l tem n elementos ou menos, retorna a lista inteira.

  Exemplo:
  iex> Ex2.ultimos_n([1, 2, 3, 4], 2)
  [3, 4]
  """
  def ultimos_n(l, n) do
    if length(l) < n do
      l
    else
      remove_primeiros_n(l, length(l) - n)
    end
  end

  def remove_primeiros_n([], _), do: []
  def remove_primeiros_n(l, 0), do: l
  def remove_primeiros_n([_h | t], n), do: remove_primeiros_n(t, n-1)


  # Em algumas situacoes, queremos transformar cada elemento de uma lista da
  # mesma forma, obtendo uma nova lista com os resultados.

  @doc """
  Dada uma lista de numeros, retorna uma nova lista com os numeros da lista
  original, multiplicados por 2.

  Exemplo:
  iex> Ex2.dobro_lista([1, 2, 3, 4])
  [2, 4, 6, 8]
  """
  def dobro_lista([]), do: []
  def dobro_lista([h | t]), do: [h*2 | dobro_lista(t)]

  @doc """
  Dada uma lista de numeros, retorna uma nova lista com os numeros da lista
  original elevados ao quadrado.

  Exemplo:
  iex> Ex2.quadrado_lista([1, 2, 3, 4])
  [1, 4, 9, 16]
  """
  def quadrado_lista([]), do: []
  def quadrado_lista([h | t]), do: [h*h | quadrado_lista(t)]

  # Uma outra necessidade comum e' selecionar apenas os elementos de uma lista
  # que possuem alguma propriedade, por exemplo apenas os numeros positivos, ou
  # apenas as strings que comecam com uma letra maiuscula.

  @doc """
  Dada uma lista de numeros, retorna uma nova lista com os numeros positivos
  da lista original.

  Exemplo:
  iex> Ex2.positivos_lista([-2, 2, 0, 88, 15, -11, 42])
  [2, 88, 15, 42]
  """
  def positivos_lista([]), do: []
  def positivos_lista([0]), do: []
  def positivos_lista([h | t]) when h > 0, do: [h | positivos_lista(t)]
  def positivos_lista([_ | t]), do: positivos_lista(t)

  @doc "Determina se o numero n (n >= 0) e' par, usando apenas subtracao"
  def numero_par(n), do: rem(n, 2) == 0

  @doc "Retorna apenas os numeros pares de uma lista de numeros."
  def pares_lista([]), do: []
  def pares_lista([h | t]) do
    if numero_par(h) do
      [h | pares_lista(t)]
    else
      pares_lista(t)
    end
  end

  # Podemos querer fazer operacoes no agregado, combinando os elementos
  # de mesma posicao em duas listas, gerando uma terceira lista. Por exemplo,
  # somar as listas [1, 2, 3] e [4, 5, 6] elemento a elemento, resultando na
  # lista [5, 7, 9].

  @doc """
  Dadas duas listas de numeros, retorna uma lista com a soma de cada elemento
  de mesma posicao nas duas listas. Se uma das listas for menor que a outra,
  retorna uma lista do tamanho da menor.

  Exemplo:
  iex> Ex2.soma_listas([1, 2, 3], [7, 8, 9, 3])
  [8, 10, 12]
  """
  def soma_listas([], _l2), do: []
  def soma_listas(_l1, []), do: []
  def soma_listas(l1, l2), do: [hd(l1) + hd(l2) | soma_listas(tl(l1), tl(l2))]

  @doc """
  Dadas duas listas de strings l1 e l2, retorna uma lista em que cada elemento
  e' a concatenacao dos elementos de mesma posicao em l1 e l2.
  Se uma das listas for menor que a outra, retorna uma lista do tamanho da menor.

  Exemplo:
  iex> Ex2.concat_listas(["a", "b", "c"], ["x", "y", "z"])
  ["ax", "by", "cz"]
  """
  def concat_listas(_l1, []), do: []
  def concat_listas([], _l2), do: []
  def concat_listas(l1, l2), do: [hd(l1)<>hd(l2) | concat_listas(tl(l1), tl(l2))]

  # Algumas outras manipulacoes de listas.

  # Dica: para append, e' possivel resolver apenas fazendo recursao e seguindo
  # a estrutura de uma das listas e pensando qual deve ser a resposta quando essa
  # lista for vazia.

  @doc """
  Junta/concatena duas listas, retornando uma lista com todos os elementos da
  primeira seguidos pelos elementos da segunda.

  Exemplo:
  iex> Ex2.append([1, 2, 3], [4, 5, 6])
  [1, 2, 3, 4, 5, 6]
  """
  def append([], []), do: []
  def append(l1, l2) do
    if(tamanho(l1) > 0) do
      [hd(l1) | append(tl(l1), l2)]
    else
      l2
    end
  end

  # Dica: para a funcao a seguir, pode ser necessario definir uma funcao auxiliar.

  @doc """
  Retorna uma lista apenas com os elementos de posicao (indice) par na lista l.
  Considere o primeiro elemento como posicao 1 (e nao 0 como seria o indice).

  Exemplo:
  iex> Ex2.posicoes_pares([2, 4, 6, 8, 10])
  [4, 8]
  """
  def posicoes_pares([]), do: []
  def posicoes_pares([_h]), do: []
  def posicoes_pares([_h | t]) do
    if(tamanho(t) == 1) do
      t
    else
      [hd(t) | posicoes_pares(tl(t))]
    end
  end
end
