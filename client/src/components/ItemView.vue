<template lang="html">
    <div class="mdl-list__item">
        <span class="mdl-list__item-primary-content">
            <slot name="picture"></slot>
            <slot name="line"></slot>
        </span>
        <span class="mdl-list__item-secondary-content">
            <slot></slot>
        </span>
    </div>
</template>

<style lang="scss" scoped>
    .list-item{
        display: flex;
    }
</style>
