# qos_base.tcl
# Arquivo base para simulações de QoS no NS2

# 1. Configuração do Simulador
set ns [new Simulator]
set nf [open base_output.nam w]
$ns namtrace-all $nf
set tr [open base_output.tr w]
$ns trace-all $tr

# 2. Função de Finalização
proc finish {} {
    global ns nf tr
    $ns flush-trace
    close $nf
    close $tr
    exec nam base_output.nam &
    puts "Simulação concluída. Arquivos base_output.nam e base_output.tr
    gerados."
    exit 0
}

# 3. Função para Criar Links com Parâmetros Padrão
proc create_link {node1 node2 bw delay queue_type} {
    global ns
    $ns duplex-link $node1 $node2 $bw $delay $queue_type
}

# 4. Função para Configurar Fila Prioritária
    proc configure_priority_queue {node1 node2 queue_limit} {
    global ns
    $ns queue-limit $node1 $node2 $queue_limit
    $ns set queue_ $node1 $node2 [new PriorityQueue]
}

# 5. Parâmetros Globais
set default_bw "1Mb" ;# Largura de banda padrão
set default_delay "10ms" ;# Latência padrão
set default_queue "DropTail" ;# Tipo de fila padrão