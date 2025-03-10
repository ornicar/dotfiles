{ pkgs, ... }: {

  # sensors tui

  home.packages = with pkgs; [ s-tui ];

  home.file.".config/s-tui/s-tui.conf".text = ''
    [GraphControl]
    refresh = 2.0
    utf8 = True

    [Temp,Graphs]
    edge,0 = True
    junction,0 = False
    mem,0 = False
    edge,1 = False
    tctl,0 = True
    mt7921_phy0,0 = False
    cpu,0 = False
    system,0 = True
    vrmmos,0 = True
    pch,0 = False
    cpusocket,0 = True
    pciex1,0 = False
    composite,0 = False
    sensor1,0 = True
    sensor2,0 = False
    spd5118,0 = True
    spd5118,1 = False

    [Frequency,Graphs]
    avg = False
    core 0 = True
    core 1 = True
    core 2 = True
    core 3 = True
    core 4 = False
    core 5 = False
    core 6 = False
    core 7 = False
    core 8 = False
    core 9 = False
    core 10 = False
    core 11 = False
    core 12 = False
    core 13 = False
    core 14 = False
    core 15 = False
    core 16 = False
    core 17 = False
    core 18 = False
    core 19 = False
    core 20 = False
    core 21 = False
    core 22 = False
    core 23 = False

    [Util,Graphs]
    avg = True
    core 0 = False
    core 1 = False
    core 2 = False
    core 3 = False
    core 4 = False
    core 5 = False
    core 6 = False
    core 7 = False
    core 8 = False
    core 9 = False
    core 10 = False
    core 11 = False
    core 12 = False
    core 13 = False
    core 14 = False
    core 15 = False
    core 16 = False
    core 17 = False
    core 18 = False
    core 19 = False
    core 20 = False
    core 21 = False
    core 22 = False
    core 23 = False

    [Power,Graphs]

    [Fan,Graphs]
    amdgpu,0 = True
    cpu fan = True
    pump fan = True
    system fan #1 = True
    system fan #2 = True
    system fan #3 = True
    system fan #4 = False
    system fan #5 = False
    system fan #6 = False

    [Temp,Summaries]
    edge,0 = True
    junction,0 = False
    mem,0 = False
    edge,1 = False
    tctl,0 = True
    mt7921_phy0,0 = False
    cpu,0 = False
    system,0 = True
    vrmmos,0 = True
    pch,0 = False
    cpusocket,0 = True
    pciex1,0 = False
    composite,0 = False
    sensor1,0 = True
    sensor2,0 = False
    spd5118,0 = True
    spd5118,1 = False

    [Frequency,Summaries]
    avg = False
    core 0 = True
    core 1 = True
    core 2 = True
    core 3 = True
    core 4 = False
    core 5 = False
    core 6 = False
    core 7 = False
    core 8 = False
    core 9 = False
    core 10 = False
    core 11 = False
    core 12 = False
    core 13 = False
    core 14 = False
    core 15 = False
    core 16 = False
    core 17 = False
    core 18 = False
    core 19 = False
    core 20 = False
    core 21 = False
    core 22 = False
    core 23 = False

    [Util,Summaries]
    avg = True
    core 0 = False
    core 1 = False
    core 2 = False
    core 3 = False
    core 4 = False
    core 5 = False
    core 6 = False
    core 7 = False
    core 8 = False
    core 9 = False
    core 10 = False
    core 11 = False
    core 12 = False
    core 13 = False
    core 14 = False
    core 15 = False
    core 16 = False
    core 17 = False
    core 18 = False
    core 19 = False
    core 20 = False
    core 21 = False
    core 22 = False
    core 23 = False

    [Power,Summaries]

    [Fan,Summaries]
    amdgpu,0 = True
    cpu fan = True
    pump fan = True
    system fan #1 = True
    system fan #2 = True
    system fan #3 = True
    system fan #4 = False
    system fan #5 = False
    system fan #6 = False
  '';
}
