import javax.swing.*;

class FrameDemo {

    public static void main(String[] args) {
        JFrame frame = new JFrame("FrameDemo");
        frame.setSize(175, 100);

        frame.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
        frame.setVisible(true);
    }
}
