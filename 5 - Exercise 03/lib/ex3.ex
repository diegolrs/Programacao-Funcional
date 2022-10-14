defmodule Ex3 do
  @moduledoc """
  Exercício 3 da disciplina LPIII - Programação Funcional
  """

  # --- Parte 1: map e seus usos -------------------------------------

  @doc """
  A função map(l, f) aplica a função f a todos os elementos da lista l,
  retornando uma lista com os elementos transformados.

  Exemplo:
  iex> Ex3.map([1, 2, 3, 4, 5], fn x -> x * 2 end)
  [2, 4, 6, 8, 10]
  """
  def map([], _f), do: []
  def map(_h, []), do: []
  def map([], []), do: []
  def map([h | t], f), do: [ f.(h) | map(t, f) ]

  @doc """
  Dada uma lista de strings, retorna uma lista com o tamanho de cada string.

  Exemplo:
  iex> Ex3.tamanho_strings(["foo", "barbaz", "tapioca"])
  [3, 6, 7]
  """
  # Dica: use a funcao String.length para obter o tamanho de uma string
  def tamanho_strings([]), do: []
  def tamanho_strings(l), do: map(l, fn x -> String.length(x) end)

  @doc """
  Dada uma lista de strings contendo apenas dígitos numéricos, retorna uma
  lista com os inteiros correspondentes a cada string.

  Exemplo:
  iex> Ex3.converte_para_inteiros(["42", "54", "999"])
  [42, 54, 999]
  """
  # Dica: use a função String.to_integer para converter cada string
  def converte_para_inteiros([]), do: []
  def converte_para_inteiros(l), do: map(l, fn x -> String.to_integer(x) end)


  @doc """
  Dada uma lista de números, retorna uma lista com cada número da lista
  original, somado a 100.

  Exemplo:
  iex> Ex3.soma_100_lista([1, 2, 3, 4, 5])
  [101, 102, 103, 104, 105]
  """
  def soma_100_lista([]), do: []
  def soma_100_lista(l), do: map(l, fn x -> x + 100  end)

  # Existem situações em que queremos aplicar um deslocamento a todos os números
  # de uma coleção, por exemplo em aplicações de processamento de sinais ou de
  # análise de dados e machine learning. O próximo exercício é uma generalização
  # do anterior.

  @doc """
  Dada uma lista de números e um valor de deslocamento, retorna uma lista com
  cada número da lista original somado ao deslocamento.

  Exemplo:
  iex> Ex3.soma_n_lista([1, 2, 3, 4, 5], 500)
  [501, 502, 503, 504, 505]
  """
  def soma_n_lista([], _n), do: []
  def soma_n_lista(l, n), do: map(l, fn x -> x + n end)

  @doc """
  Dada uma lista de strings, adiciona um prefixo a cada string da lista,
  retornando uma lista com os resultados.

  Exemplo:
  iex> Ex3.adiciona_prefixo(["fazer", "tornar", "bater"], "re")
  ["refazer", "retornar", "rebater"]
  """
  def adiciona_prefixo([], _pre), do: []
  def adiciona_prefixo(_l, []), do: []
  def adiciona_prefixo(l, pre), do: map(l, fn x -> pre <> x end)

  @doc """
  Dada uma lista de strings, adiciona um sufixo a cada string da lista,
  retornando uma lista com os resultados.

  Exemplo:
  iex> Ex3.adiciona_sufixo(["geo", "bio", "crono"], "logia")
  ["geologia", "biologia", "cronologia"]
  """
  def adiciona_sufixo(_l, []), do: []
  def adiciona_sufixo([], _sufixo), do: []
  def adiciona_sufixo(l, sufixo), do: map(l, fn x -> x <> sufixo end)


  # --- Parte 2: Reduções (fold_left, fold_right) --------------------

  @doc """
  fold_right(l, ini, f) reduz os elementos da lista l de acordo com a
  função f, tendo ini como valor inicial. As operações devem ser agrupadas
  à direita.

  Exemplo:
  iex> Ex3.fold_right([1, 2, 3, 4], 0, fn (x, s) -> x + s end)
  10
  """
  def fold_right([], ini, _f), do: ini
  def fold_right([h | t], ini, f), do: f.(h, fold_right(t, ini, f))

  @doc """
  Dada uma lista de strings, retorna uma string que é a concatenação de todas
  as strings na lista.

  Exemplo:
  iex> Ex3.concatena_strings(["foo", "bar", "baz"])
  "foobarbaz"
  """
  def concatena_strings([]), do: ""
  def concatena_strings(ls), do: fold_right(ls, "", fn x, y -> x <> y end)

  @doc """
  Dada uma lista de valores booleanos, calcula o AND (E-lógico) de todos os
  valores.

  Exemplo:
  iex> Ex3.and_lista([true, false, true])
  false
  """
  def and_lista([]), do: true
  def and_lista(lb), do: fold_right(lb, true, fn x, y -> x and y end)

  @doc """
  Dada uma lista de valores booleanos, calcula o OR (OU-lógico) de todos os
  valores.

  Exemplo:
  iex> Ex3.or_lista([true, false, true])
  true
  """
  def or_lista([]), do: false
  def or_lista(lb), do: fold_right(lb, false, fn x, y -> x or y end)

  # fold-right sempre associa a operação f à direita, e isso pode ser
  # inadequado em muitos casos. Usando o modelo de substituição, podemos
  # ver que a chamada fold_right([1, 2, 3], val, f) terá o valor de
  # f(1, f(2, f(3, val)))
  #
  # Em operadores associativos como adição e multiplicação isso não é problema,
  # mas muitas vezes precisamos associar à esquerda mesmo. Um exemplo é na
  # subtração.
  #
  # Considere uma aplicação para controlar a pontuação de pessoas fazendo uma prova
  # de avaliação de habilidade em que cada um começa com o máximo de pontos, e
  # a cada erro vai causando deduções (similar ao formato de prova prática para
  # carteira de habilitação para dirigir veículos em muitos lugares). O avaliador
  # preenche uma lista com as deduções, e a pontuação inicial é fixa.
  #
  # Suponha que a pontuação inicial seja de 1000 pontos e o avaliador anotou, para
  # uma pessoa, as deduções 10, 20 e 40. O resultado esperado é calculado facilmente:
  # primeiro subtrai-se 10 de 1000, resultando em 990; disto, tiramos 20, chegando a
  # 970, e finalmente subtrai-se mais 40, tendo como resultado final 930.
  #
  # Se tentarmos calcular isso usando
  # fold_right([10, 20, 40], 1000, fn (x, r) -> x - r end), o resultado
  # será dado por (10 - (20 - (40 - 1000))), com resultado -970, claramente errado.
  #
  # Nesse caso é necessário calcular (((1000 - 10) - 20) - 40).
  # Em termos mais gerais,
  # dado a operação f e o valor inicial val precisamos calcular, \
  # para a lista [1, 2, 3], o valor
  # f(f(f(val, 1), 2), 3).
  # Isso é o que faz a função fold_left.

  @doc """
  fold_left(l, ini, f) reduz os elementos da lista l de acordo com a
  função f, tendo ini como valor inicial. As operações devem ser agrupadas
  à esquerda.

  Exemplo:
  iex> Ex3.fold_left([10, 20, 40], 1000, fn (r, x) -> r - x end)
  930
  """
  def fold_left([], ini, _f), do: ini
  def fold_left([h | t], ini, f), do: fold_left(t, f.(ini, h), f)

  @doc """
  Dada uma pontuação inicial e uma lista de deduções, calcula a pontuação
  final.

  Exemplo:
  iex> Ex3.pontuacao_final(1000, [30, 40, 15])
  915
  """
  #def pontuacao_final(ini, []), do: ini
  def pontuacao_final(ini, deducoes), do: fold_left(deducoes, ini, fn x, y -> x - y end)

  @doc """
  Dada uma lista de listas, concatena todas as listas e retorna o resultado.

  Exemplo:
  iex> Ex3.concatena_listas([[1, 2], [3, 4], [7, 8, 9]])
  [1, 2, 3, 4, 7, 8, 9]
  """
  def concatena_listas(ll), do: fold_left(ll, [], fn x, y -> x ++ y end)
  # Dica: o operador ++ concatena duas listas

  # Opcional: a funcao concatena_listas é mais eficiente se implementada com
  # fold_right ou fold_left? Se quiser, faça experimentos para medir o tempo
  # e descobrir experimentalmente qual das duas é mais rápida.
  # Considerando como a concatenação de duas listas é implementada, é possível
  # descobrir qual é mais eficiente sem precisar comparar as implementações.
  # Mesmo assim, uma comprovação experimental é interessante.


  @doc """
  Dada uma lista de strings e um separador (também string), retorna a
  concatenação das strings da lista, separados pelo separador.

  Exemplo:
  iex> Ex3.concat_strings_sep(["tapioca", "cuscuz", "queijo"], ", ")
  "tapioca, cuscuz, queijo"
  """
  def concat_strings_sep([], _sep), do: ""
  def concat_strings_sep([h | t], sep), do: h <> fold_left(t, "", fn x, y -> x <> sep <> y end)


  # --- Parte 3: Filtragem -------------------------------------------

  @doc """
  A função filter(l, pred) retorna apenas os elementos da lista l para
  os quais o predicado pred retorna true.

  Exemplo:
  iex> Ex3.filter([1, 22, 3, 7, 16], fn n -> n > 10 end)
  [22, 16]
  """
  def filter([], _pred), do: []
  def filter([h | t], pred) do
    if pred.(h) do
      [h | filter(t, pred)]
    else
      filter(t, pred)
    end
  end

  @doc """
  strings_que_contem(ls, meio) retorna apenas as strings da lista ls que contem
  a string meio entre seus caracteres.

  Exemplo:
  iex> Ex3.strings_que_contem(["foo", "euforia", "bar", "Moria", "tapioca"], "oria")
  ["euforia", "Moria"]
  """
  def strings_que_contem(ls, meio), do: filter(ls, fn x -> String.contains?(x, meio) end)
  # Dica: use a função String.contains? para decidir se uma string contem outra

  @doc """
  Dada uma lista de números, retorna os números n tais que, quando multiplicados
  por 3 e somados a 1, resultam em um número par.

  Exemplo:
  iex> Ex3.par_3n_mais_1([1, 2, 3, 4, 5])
  [1, 3, 5]
  """
  def par_3n_mais_1(l), do: filter(l, fn x -> numero_par(x*3 + 1) end)

  @doc "Determina se o numero n (n >= 0) é par"
  def numero_par(n), do: rem(n, 2) == 0
end
