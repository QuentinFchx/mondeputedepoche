<template lang="html">
    <div class="intervention">
        <div class="intervenant" v-if="!fromPov">
            <span v-if="intervention.intervenant">{{ intervention.intervenant.displayName }}</span>
            <img :src="intervention.intervenant.image.url"
                 :alt="intervention.intervenant.displayName"
                 v-if="intervention.intervenant">
            <img src="../../assets/icon.png" v-if="!intervention.intervenant">
        </div>
        <div class="content" :class="{ other: !this.fromPov }">
            <p v-for="part in filteredInterventions">{{ part.content }}</p>
        </div>
    </div>
</template>

<script>
export default {
    props: ['intervention', 'fromPov'],
    computed: {
        filteredInterventions: function(){
            return this.intervention.parts.filter(part => part.type == 'text')
        }
    }
}
</script>

<style lang="scss" scoped>
    @import '../../styles/vars.scss';

    .intervenant {
        text-align: right;
        font-size: smaller;

        img {
            display: block;
            position: absolute;
            right: 0;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            object-fit: cover;
        }
    }

    .intervention {
        position: relative;
        margin-bottom: 5px;
    }

    .content {
        display: flex;
        flex-direction: column;
        padding-right: 30px;

        &.other {
            align-items: flex-end;

            > p {
                background-color: $light-gray;

                &:first-child {
                    border-top-right-radius: 0;
                }
            }
        }

        &:not(.other) {
            > p {
                background: $blue;
                color: white;

                &:first-child {
                    border-top-left-radius: 0;
                }
            }
        }

        > p {
            margin-top: 0;
            margin-bottom: 2px;
            max-width: 80%;
            padding: 8px;
            font-weight: lighter;

            $radius: 10px;
            &:first-child {
                border-top-left-radius: $radius;
                border-top-right-radius: $radius;
            }

            &:last-child {
                border-bottom-left-radius: $radius;
                border-bottom-right-radius: $radius;
            }
        }
    }
</style>
