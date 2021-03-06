### Frame과 Bound

#### Frame이란?

: 뷰의 위치와 크기를 지정하는 데에 사용되는 속성이다. <code>UIView</code> 클래스는 frame 속성을 인자값으로 하는 초기화 메소드를 제공한다.

> public init(frame: CGRect)

그렇다면 frame 속성의 (x, y) 값을 변경하면 뷰의 좌표가 변경되며, 그에 따라 화면에서 뷰의 위치도 옮겨진다.

하지만 실제로 옮겨진 뷰의 위치를 계산할 때는 주의해야한다. Frame 속성의 좌표값이 가리키는 위치는 자신의 상위 뷰를 기준으로 하는 상대적인 값이기 때문이다.

#### Bound란?

: frame 속성과 여러모로 비슷하지만 bound는 frame과 다르게 좌표 기준이 자기 자신이다. 그래서 (x, y)의 값이 항상 (0, 0)을 가진다.

그래서 bound 속성은 뷰의 내부에 있는 객체와의 관계에서 사용한다. 주로 뷰 내부에 서브 뷰를 추가하기 위해 원점 좌표가 필요할 때 사용하는 경우가 많다.

 