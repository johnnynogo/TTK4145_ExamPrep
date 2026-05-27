with Ada.Text_IO; use Ada.Text_IO;

procedure Main is

    protected Rendezvous is
        procedure A1Done;
        procedure B1Done;
        entry WaitForA1;
        entry WaitForB1;
    private
        A1Finished : Boolean := False;
        B1Finished : Boolean := False;
    end Rendezvous;

    protected body Rendezvous is
        procedure A1Done is
        begin
            A1Finished := True;
        end A1Done;

        procedure B1Done is
        begin
            B1Finished := True;
        end B1Done;

        entry WaitForA1 when A1Finished is
        begin null; end WaitForA1;

        entry WaitForB1 when B1Finished is
        begin null; end WaitForB1;
    end Rendezvous;

    -- Thread A
    task ThreadA;
    task body ThreadA is
    begin
        Put_Line("a1 running");
        Rendezvous.A1Done;
        Rendezvous.WaitForB1;
        Put_Line("a2 running");
    end ThreadA;

    -- Thread B
    task ThreadB;
    task body ThreadB is
    begin
        Put_Line("b1 running");
        Rendezvous.B1Done;
        Rendezvous.WaitForA1;
        Put_Line("b2 running");
    end ThreadB;

begin
    null;  -- tasks start automatically when Main begins
end Main;