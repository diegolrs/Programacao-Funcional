defmodule Ex5serv do
  @doc "Inicializa o servidor em um processo separado e retorna o PID."
  def start do
    # os parametros sao a quantidade inicial de pacotes
    # de cafe e cha, respectivamente
    spawn(Ex5serv, :loop, [20, 30])
  end

  def hello do
    :world
  end

  # Implemente um servidor que responde as seguintes requisicoes:
  #
  # - { pid, :compra_cafe, n } : processa uma compra de n pacotes de
  #   cafe. se houver pacotes suficientes em estoque, responde { :ok, n }
  #   onde n e' o numero de pacotes comprados. Se nao tiver estoque para
  #   vender n pacotes, vende o que tiver disponivel, respondendo com
  #   { :semestoque, p }, onde p e' o numero de pacotes que estavam
  #   disponiveis.
  #
  # - { pid, :compra_cha, n } : funciona da mesma forma da mensagem para
  #   compra de cafe, mas para compra de pacotes de cha (o estoque de cafe e cha
  #   devem ser mantidos separadamente).
  #
  # - { pid, :quant_cafe } : responde com { :ok, p } onde p e' o numero de
  #   pacotes de cafe atualmente no estoque. Nao altera o estoque.
  #
  # - { pid, :quant_cha } : responde com { :ok, p } onde p e' o numero de
  #   pacotes de cha atualmente no estoque. Nao altera o estoque.
  #
  # Opcionalmente, aceite uma mensagem para finalizar o servidor.


  #Commands----
  #  c("ex5serv.ex") #compilar
  #  pid = Ex5serv.start #iniciar processo

  #  Enviar requisições ---
  #  send pid, {self(), :compra_cafe, 5} #fazer requisição
  #  send pid, {self(), :quant_cafe} #requisitar quantidade

  #  Receber requisições ---
  #  receive do { :ok, s} -> IO.puts s end #lidar com resposta
  #  receive do { :semestoque, s} -> IO.puts s end #lidar com resposta

  #  Aguardar por apenas n segundos
  #  receive do
  #    { :ok, s} -> IO.puts s
  #  after 2000 ->
  #      IO.puts "Processo nao respondeu"
  #  end
  #----

  def loop(cafe, cha) do
    receive do
      { pid, :compra_cafe, n } ->
        if canBuy(n, cafe) do
          send pid, { :ok, n }
          loop(cafe-n, cha)
        else
          send pid, { :semestoque, cafe }
          loop(0, cha)
        end

      { pid, :compra_cha, n } ->
        if canBuy(n, cha) do
          send pid, { :ok, n }
          loop(cafe, cha-n)
        else
          send pid, { :semestoque, cha }
          loop(cafe, 0)
        end

      { pid, :quant_cafe } ->
        send pid, { :ok, cafe }
        loop(cafe, cha)

      { pid, :quant_cha } ->
        send pid, { :ok, cha }
        loop(cafe, cha)

      { pid, :shutdown } ->
        send pid, { :ok, "Processo finalizado" }
    end
  end

  #Se a compra eh possivel de ser feita
  def canBuy(qtd, qtd_total) do
    (qtd_total - qtd) >= 0
  end
end
