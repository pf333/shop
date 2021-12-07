package com.shop.entity;

import com.shop.constant.ItemSellStatus;
import com.shop.dto.ItemFormDto;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity //JPA가 관리할 객체
@Table(name = "item") //객체와 테이블 매핑
@Getter
@Setter
@ToString
public class Item extends BaseEntity {

    @Id //기본 키 직접 할당
    @Column(name = "item_id") //필드와 컬럼 매핑
    @GeneratedValue(strategy = GenerationType.AUTO) //기본 키 자동 생성
    private Long id; //상품 코드

    @Column(nullable = false, length = 50)
    private String itemNm; //상품명

    @Column(nullable = false)
    private int price; //가격

    @Column(nullable = false)
    private int stockNumber; //재고수량

    @Lob //필드의 타입이 byte[]인 경우 BLOB 타입, char[] 또는 String인 경우 CLOB 타입 매핑
    @Column(nullable = false)
    private String itemDetail; //상품 상세 설명

    @Enumerated(EnumType.STRING) //필드의 타입이 enum 타입인 경우 매핑
    private ItemSellStatus itemSellStatus; //상품 판매 상태

    public void updateItem(ItemFormDto itemFormDto) {
        this.itemNm = itemFormDto.getItemNm();
        this.price = itemFormDto.getPrice();
        this.stockNumber = itemFormDto.getStockNumber();
        this.itemDetail = itemFormDto.getItemDetail();
        this.itemSellStatus = itemFormDto.getItemSellStatus();
    }

}