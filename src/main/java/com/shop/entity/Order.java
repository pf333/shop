package com.shop.entity;

import com.shop.constant.OrderStatus;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
public class Order extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "order_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY/*지연 로딩(객체가 실제로 사용될 때 로딩)*/)
    @JoinColumn(name = "member_id") //외래키 매핑
    private Member member;

    private LocalDateTime orderDate; //주문일

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus; //주문상태

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL/*Order Entity에 변경이 있을 시 모든 변경 사항이 OrderItem Entity에 반영*/,
            orphanRemoval = true/*Order Entity와 연관관계가 끊어진 OrderItem Entitiy 삭제*/, fetch = FetchType.LAZY)
    private List<OrderItem> orderItems = new ArrayList<>();

}