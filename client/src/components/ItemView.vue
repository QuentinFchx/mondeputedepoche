<template lang="html">
    <div class="list__item">
        <slot name="picture"></slot>
        <slot name="line"></slot>
        <slot></slot>
    </div>
</template>

<style lang="scss" scoped>
    .list-item{
        display: flex;
    }
</style>
