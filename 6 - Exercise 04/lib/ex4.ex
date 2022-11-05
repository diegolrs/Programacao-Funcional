defmodule Ex4 do

  # Recursao de cauda e acumuladores

  # Aqui esta a versao recursiva normal que vimos para a funcao soma

  @doc "Soma os numeros a e b."
  def soma_rec(a, 0), do: a
  def soma_rec(a, b), do: 1 + soma_rec(a, b - 1)

  # Esta funcao nao apresenta recursividade de cauda, pois precisa somar
  # 1 ao resultado da chamada recursiva.

  # Escreva uma funcao similar de soma que tenha recursividade de cauda.
  # Use um parametro acumulador para evitar a soma apos a chamada recursiva.

  # Voce pode criar uma funcao auxiliar privada com o parametro acumulador,
  # ou fazer de outra forma.
  def soma(a, b), do: soma_acc(a, b, 0)
  defp soma_acc(a, 0, total), do: a + total
  defp soma_acc(a, b, total), do: soma_acc(a, b-1, total+1)

  # Escreva as funcoes a seguir usando recursividade de cauda. Se precisar,
  # crie funcoes auxiliares que usam um parametro acumulador.

  # Obs: os testes nao vao testar se as funcoes apresentam recursividade
  # de cauda ou nao, apenas se o objetivo da funcao e' cumprido.


  @doc "Multiplica os numeros a e b (b >= 0), usando apenas somas."
  def mult(a, b), do: mult_acc(a, b, 0)
  defp mult_acc(_a, 0, total), do: total
  defp mult_acc(0, _b, total), do: total
  defp mult_acc(a, b, total), do: mult_acc(a, b-1, a+total)

  @doc "Obtem o tamanho da lista l."
  def tamanho(l), do: tamanho_acc(l, 0)
  defp tamanho_acc([], a), do: a
  defp tamanho_acc([_ | t], a), do: tamanho_acc(t, a + 1)

  @doc """
  Replica a string s, n vezes.

  Exemplo:
  iex> Ex4.replica("ruby", 4)
  "rubyrubyrubyruby"
  """
  def replica(s, n), do: replica_acc(s, n, "")
  defp replica_acc(_s, 0, total), do: total
  defp replica_acc(s, n, total), do: replica_acc(s, n-1, total <> s)

  @doc """
  Aplica a funcao f em cada elemento da lista l, retornando uma nova lista
  com os elementos transformados.

  Exemplo:
  iex> Ex4.map([1, 2, 3], fn x -> x * 2 end)
  [2, 4, 6]
  """
  def map(l, f), do: map_acc(l, f, [])
  defp map_acc([], _f, total), do: total
  defp map_acc(_h, [], total), do: total
  defp map_acc([], [], total), do: total
  defp map_acc([h | t], f, total), do: map_acc(t, f, append(total, [f.(h)]))

  @doc "Calcula a soma dos numeros da lista l."
  def soma_lista(l), do: soma_lista_acc(l, 0)
  defp soma_lista_acc([], total), do: total
  defp soma_lista_acc([h | t], total), do: soma_lista_acc(t, total + h)

  @doc "Calcula o produto dos numeros da lista l."
  def mult_lista(l), do: mult_lista_acc(l, 1)
  defp mult_lista_acc([], total), do: total
  defp mult_lista_acc(l, total) do
    if tamanho(l) == 1 do
      mult_lista_acc([], hd(l) * total)
    else
      mult_lista_acc(tl(l), hd(l) * total)
    end
  end

  @doc "Retorna uma string que e' a concatenacao de todas as strings na lista ls."
  def concat_lista(ls), do: concat_lista_acc(ls, "")
  defp concat_lista_acc([], total), do: total
  defp concat_lista_acc([h | t], total), do: concat_lista_acc(t, total <> h)

  @doc """
  Retorna uma lista com os elementos da lista l para os quais o predicado p
  retorna true.



  Exemplo:
  iex> Ex4.filter([10, 2, 15, 9, 42, 27], fn x -> x > 10 end)
  [15, 42, 27]
  """
  def filter(l, p), do: filter_acc(l, p, [])
  defp filter_acc([], _pred, total), do: total
  defp filter_acc([h | t], pred, total) do
    if pred.(h) do
      filter_acc(t, pred, append(total, [h]))
    else
      filter_acc(t, pred, total)
    end
  end

  @doc """
  Junta/concatena duas listas, retornando uma lista com todos os elementos da
  primeira seguidos pelos elementos da segunda.
  Exemplo:
  iex> Ex4.append([1, 2, 3], [4, 5, 6])
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
end
